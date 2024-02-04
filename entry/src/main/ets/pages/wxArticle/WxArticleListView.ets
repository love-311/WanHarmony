import { PullToRefresh } from '@ohos/pulltorefresh'
import { StrUtil } from '@yunkss/eftool'
import { StyleConstants } from '../../constants/StyleConstants'
import ArticleListModel from '../../entity/ArticleListModel'
import { PageData } from '../../entity/PageData'
import WxArticleAuthorModel from '../../entity/WxArticleAuthorModel'
import { jumpToWeb } from '../../utils/Common'
import { Logger } from '../../utils/Logger'
import WxArticleViewModel from '../../viewmodel/WxArticleViewModel'

@Component
export struct WxArticleListView {
  authorModel: WxArticleAuthorModel
  @State articleListData: PageData<ArticleListModel>[] = []
  pageNum: number = 1
  private scroller: Scroller = new Scroller()

  aboutToAppear() {
    this.getArticleListData()
  }

  build() {
    PullToRefresh({
      data: $articleListData,
      scroller: this.scroller,
      customList: () => {
        this.ArticleListView()
      },
      onRefresh: () => {
        this.pageNum = 1
        return this.getArticleListData()
      },
      onLoadMore: () => {
        this.pageNum++
        return this.getArticleListData()
      },
      customRefresh: null,
      customLoad: null
    })
  }

  @Builder
  ArticleListView() {
    List({ scroller: this.scroller }) {
      ForEach(this.articleListData, (item: ArticleListModel) => {
        ListItem() {
          Flex() {
            Column() {
              Text(item.title).fontSize($r('app.float.middle_font_size'))
              Row() {
                Image($r('app.media.ic_author'))
                  .width($r('app.float.vp_twelve'))
                  .height($r('app.float.vp_twelve'))
                Text(StrUtil.isBlank(item.author) ? '分享者：' + item.shareUser : item.author)
                  .margin({ left: $r('app.float.vp_four') })
                  .fontSize($r('app.float.smaller_font_size'))
                Image($r('app.media.ic_time'))
                  .width($r('app.float.vp_twelve'))
                  .height($r('app.float.vp_twelve'))
                  .margin({ left: $r('app.float.vp_twelve') })
                Text(item.niceDate)
                  .margin({ left: $r('app.float.vp_four') })
                  .fontSize($r('app.float.smaller_font_size'))
              }
              .margin({ top: $r('app.float.vp_eight') })
            }
            .alignItems(HorizontalAlign.Start)
          }
          .margin({
            left: $r('app.float.vp_twelve'),
            top: $r('app.float.vp_six'),
            right: $r('app.float.vp_twelve'),
            bottom: $r('app.float.vp_six')
          })
          .padding($r('app.float.vp_twelve'))
          .borderRadius($r('app.float.vp_six'))
          .backgroundColor($r('app.color.page_background'))
          .onClick(() => {
            Logger.error("onClick")
            jumpToWeb(item.title, item.link)
          })
        }
      })
    }
    .width(StyleConstants.FULL_WIDTH)
    .height(StyleConstants.FULL_HEIGHT)
    .edgeEffect(EdgeEffect.None)
  }

  getArticleListData(): Promise<string> {
    return new Promise((resolve, reject) => {
      WxArticleViewModel.getAuthorArticleList(this.authorModel.id.toString(), this.pageNum)
        .then((articleList: PageData<ArticleListModel>[]) => {
          if (this.pageNum == 1) {
            this.articleListData = articleList
          } else {
            this.articleListData = this.articleListData.concat(articleList)
            Logger.error("onLoadMore getArticleListData" + this.articleListData.length)
          }
          resolve('刷新成功')
        })
        .catch((err: Error) => {
          reject('刷新失败')
          Logger.error('getArticleListData failed', err.message)
        });
    })
  }
}