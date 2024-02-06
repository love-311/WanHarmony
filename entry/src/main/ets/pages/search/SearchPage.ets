import { PullToRefresh } from '@ohos/pulltorefresh'
import { StyleConstants } from '../../constants/StyleConstants'
import { Logger } from '../../utils/Logger'
import ArticleListModel from '../../entity/ArticleListModel'
import { PageData } from '../../entity/PageData'
import { StrUtil } from '@yunkss/eftool'
import { jumpToWeb } from '../../utils/Common'
import SearchViewModel from '../../viewmodel/SearchViewModel'
import HotKeyModel from '../../entity/HotKeyModel'

@Component
export struct SearchPage {
  @State articleListData: PageData<ArticleListModel>[] = []
  @State hotKeyListData: HotKeyModel[] = []
  // 需绑定列表或宫格组件
  private scroller: Scroller = new Scroller()
  @State private keyWords: string = ''
  private pageNum: number = 0
  @State private isShowSearchList: boolean = false

  build() {
    Flex() {
      Column() {
        Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center }) {
          TextInput({ placeholder: '请输入你想要查询的内容关键字', text: this.keyWords })
            .onChange((value: string) => {
              this.keyWords = value
              if (StrUtil.isEmpty(value)) {
                this.isShowSearchList = false
              } else {
                this.isShowSearchList = true
              }
              console.info(value);
            })
            .padding($r('app.float.vp_ten'))
            .margin($r('app.float.vp_ten'))

          Button('搜索', { type: ButtonType.Normal, stateEffect: true })
            .borderRadius(8)
            .backgroundColor($r('app.color.tag_color'))
            .onClick(() => {
              this.pageNum = 0
              this.getSearchListData()
            })
            .padding({
              left: $r('app.float.vp_ten'),
              top: $r('app.float.vp_four'),
              right: $r('app.float.vp_ten'),
              bottom: $r('app.float.vp_four')
            })
            .margin({ right: $r('app.float.vp_ten') })
        }.margin({ top: $r('app.float.vp_eighteen') })

        Stack() {
          Column() {
            Text("搜索热词")
              .fontColor($r('app.color.tag_color'))
              .fontSize($r('app.float.big_font_size'))
              .margin($r('app.float.vp_ten'))
            Flex({ wrap: FlexWrap.Wrap, direction: FlexDirection.Row }) {
              ForEach(
                this.hotKeyListData, (item: HotKeyModel) => {
                Text(item.name)
                  .fontColor(Color.White)
                  .padding({
                    left: $r('app.float.vp_ten'),
                    top: $r('app.float.vp_four'),
                    right: $r('app.float.vp_ten'),
                    bottom: $r('app.float.vp_four')
                  })
                  .margin({
                    left: $r('app.float.vp_ten'),
                    top: $r('app.float.vp_four'),
                    right: $r('app.float.vp_ten'),
                    bottom: $r('app.float.vp_four')
                  })
                  .backgroundColor($r('app.color.tag_color'))
                  .borderRadius(8)
                  .onClick(() => {
                    this.keyWords = item.name
                    this.getSearchListData()
                  })
              })
            }
          }.justifyContent(FlexAlign.Start)
          .alignItems(HorizontalAlign.Start)
          .visibility(this.isShowSearchList ? Visibility.Hidden : Visibility.Visible)

          PullToRefresh({
            data: $articleListData,
            scroller: this.scroller,
            customList: () => {
              // 一个用@Builder修饰过的UI方法
              this.SearchListView();
            },
            // 可选项，下拉刷新回调
            onRefresh: () => {
              Logger.error("onRefresh" + this.articleListData.length)
              this.pageNum = 0
              return this.getSearchListData()
            },
            // 可选项，上拉加载更多回调
            onLoadMore: () => {
              Logger.error("onLoadMore" + this.articleListData.length)
              this.pageNum++
              return this.getSearchListData()
            },
            customRefresh: null,
            customLoad: null
          }).visibility(this.isShowSearchList ? Visibility.Visible : Visibility.Hidden)
        }.alignContent(Alignment.TopStart)

      }
      .backgroundColor(Color.White)
      .width(StyleConstants.FULL_WIDTH)
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
    }
  }

  aboutToAppear() {
    this.getHotKeyData()
  }

  //获取搜索列表数据
  getSearchListData(): Promise<string> {
    return new Promise((resolve, reject) => {
      SearchViewModel.getSearchList(this.keyWords, this.pageNum).then((articleList: PageData<ArticleListModel>[]) => {
        this.isShowSearchList = true
        if (this.pageNum == 0) {
          this.articleListData = articleList
        } else {
          this.articleListData = this.articleListData.concat(articleList)
          Logger.error("onLoadMore getSearchList" + this.articleListData.length)
        }
        resolve('刷新成功')
      }).catch((err: Error) => {
        reject('刷新失败')
        Logger.error('getSearchListData failed', err.message)
      });
    })
  }

  getHotKeyData(): Promise<string> {
    return new Promise((resolve, reject) => {
      SearchViewModel.getHotKey().then((hotKeyList: HotKeyModel[]) => {
        this.hotKeyListData = hotKeyList
        resolve('刷新成功')
      }).catch((err: Error) => {
        reject('刷新失败')
        Logger.error('getSearchListData failed', err.message)
      });
    })
  }

  @Builder
  SearchListView() {
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
    .edgeEffect(EdgeEffect.None) // 必须设置列表为滑动到边缘无效果
  }
}