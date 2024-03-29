import { StyleConstants } from '../../constants/StyleConstants'
import HomeBannerModel from '../../entity/HomeBannerModel'
import HomeViewModel from '../../viewmodel/HomeViewModel'
import { PageData } from '../../entity/PageData'
import { PullToRefresh } from '@ohos/pulltorefresh'
import { Logger } from '../../utils/Logger'
import { StrUtil } from '@yunkss/eftool'
import { jumpToWeb } from '../../utils/Common'
import ArticleListModel from '../../entity/ArticleListModel'

@Component
export struct HomePage {
  //未知原因必须有初始数据才不会崩溃，貌似是swiper在数据为空时的问题
  @State homeBannerList: HomeBannerModel[] = [
    new HomeBannerModel("我们支持订阅啦~", 30, "https://www.wanandroid.com/blogimgs/42da12d8-de56-4439-b40c-eab66c227a4b.png",
      1, 2, "我们支持订阅啦~", 0, "https://www.wanandroid.com/blog/show/3352")
  ]
  @State articleListData: ArticleListModel[] = []
  @State topArticleListData: ArticleListModel[] = []
  // 需绑定列表或宫格组件
  private scroller: Scroller = new Scroller()
  private pageNum: number = 0

  build() {
    Flex({ direction: FlexDirection.Column }) {
      this.CustomSwiper()
      PullToRefresh({
        data: $articleListData,
        scroller: this.scroller,
        customList: () => {
          // 一个用@Builder修饰过的UI方法
          this.HomeArticleListView();
        },
        // 可选项，下拉刷新回调
        onRefresh: () => {
          Logger.error("onRefresh" + this.articleListData.length)
          this.pageNum = 0
          return this.getArticleListData(this.pageNum)
        },
        // 可选项，上拉加载更多回调
        onLoadMore: () => {
          Logger.error("onLoadMore" + this.articleListData.length)
          this.pageNum++
          return this.getArticleListData(this.pageNum)
        },
        customRefresh: null,
        customLoad: null
      })
        .backgroundColor(Color.White)
        .width(StyleConstants.FULL_WIDTH)
    }

  }

  aboutToAppear() {
    this.getBannerData()
    this.getTopArticleListData()
    this.getArticleListData(0)
  }

  //获取banner数据
  getBannerData() {
    HomeViewModel.getHomeBanner().then((bannerList: HomeBannerModel[]) => {
      this.homeBannerList = bannerList
    })
  }

  //获取置顶文章数据
  getTopArticleListData() {
    HomeViewModel.getTopArticleList().then((topArticleList: ArticleListModel[]) => {
      for (let i = 0; i < topArticleList.length; i++) {
        topArticleList[i].isTop = true
      }
      this.topArticleListData = topArticleList
    }).catch((err: Error) => {
      Logger.error('getTopArticleListData failed', err.message)
    });
  }

  //获取文章数据
  getArticleListData(pageNum: number): Promise<string> {
    return new Promise((resolve, reject) => {
      HomeViewModel.getArticleList(pageNum).then((articleList: ArticleListModel[]) => {
        if (pageNum == 0) {
          this.articleListData = articleList
        } else {
          this.articleListData = this.articleListData.concat(articleList)
          Logger.error("onLoadMore getArticleListData" + this.articleListData.length)
        }
        resolve('刷新成功')
      }).catch((err: Error) => {
        reject('刷新失败')
        Logger.error('getArticleListData failed', err.message)
      });
    })
  }

  @Builder
  CustomSwiper() {
    Swiper() {
      ForEach(this.homeBannerList, (item: HomeBannerModel) => {
        Image(item.imagePath)
          .width(StyleConstants.FULL_WIDTH)
          .aspectRatio(StyleConstants.IMAGE_ASPECT_RATIO)
          .borderRadius($r('app.float.vp_sixteen'))
          .backgroundColor(Color.White)
      }, (item: HomeBannerModel) => JSON.stringify(item.imagePath))
    }
    .indicatorStyle({ selectedColor: $r('app.color.indicator_select') })
    .autoPlay(true)
    .width(StyleConstants.FULL_WIDTH)
    .indicator(true)
    .displayCount(StyleConstants.DISPLAY_ONE)
    .padding($r('app.float.vp_twelve'))
    .visibility(this.homeBannerList.length > 0 ? Visibility.Visible : Visibility.Hidden)
  }

  @Builder
  HomeArticleListView() {
    List({ scroller: this.scroller }) {
      ForEach(this.topArticleListData.concat(this.articleListData), (item: ArticleListModel) => {
        ListItem() {
          Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Start }) {
            Text(item.title).fontSize($r('app.float.middle_font_size'))
            Row() {
              Text('置顶')
                .fontColor($r('app.color.focus_color'))
                .fontSize($r('app.float.micro_font_size'))
                .padding({
                  left: $r('app.float.vp_six'),
                  top: $r('app.float.vp_two'),
                  right: $r('app.float.vp_six'),
                  bottom: $r('app.float.vp_two')
                })
                .margin({
                  right: $r('app.float.vp_ten'),
                })
                .backgroundColor(Color.Transparent)
                .borderRadius(0)
                .borderColor($r('app.color.focus_color'))
                .borderWidth(1)
                .visibility(item.isTop ? Visibility.Visible : Visibility.None)

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
            .width(StyleConstants.FULL_WIDTH)
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
