import Constants from '../../constants/Constants'
import { StyleConstants } from '../../constants/StyleConstants'
import WxArticleAuthorModel from '../../entity/WxArticleAuthorModel'
import WxArticleViewModel from '../../viewmodel/WxArticleViewModel'
import { WxArticleListView } from './WxArticleListView'

@Component
export struct WxArticlePage {
  @State wxArticleAuthorList: WxArticleAuthorModel[] = []
  @State currentTabIndex: number = 0
  private tabsController: TabsController = new TabsController()

  build() {
    Flex() {
      Column() {
        Tabs({ barPosition: BarPosition.Start, index: this.currentTabIndex, controller: this.tabsController }) {
          ForEach(this.wxArticleAuthorList, (item: WxArticleAuthorModel, index: number) => {
            TabContent() {
              WxArticleListView({ authorModel: item })
            }.tabBar(this.tabBuilder(index))
          }, (item: WxArticleAuthorModel) => {
            return item.id + ""
          })
        }
        .barMode(BarMode.Scrollable)
        .onChange((index: number) => {
          animateTo({ duration: Constants.ANIMATION_DURATION }, () => {
            this.currentTabIndex = index
          })
        }).layoutWeight(1)
      }
    }
    .width(StyleConstants.FULL_WIDTH)
    .height(StyleConstants.FULL_HEIGHT)
    .backgroundColor(Color.White)
  }

  aboutToAppear() {
    this.getWxArticleAuthor()
  }

  getWxArticleAuthor() {
    WxArticleViewModel.getWxArticleAuthor().then(
      (wxArticleAuthorList: WxArticleAuthorModel[]) => {
        this.wxArticleAuthorList = wxArticleAuthorList
      })
  }

  @Builder
  tabBuilder(index: number) {
    Text(this.wxArticleAuthorList[index].name)
      .fontColor(this.currentTabIndex == index ? $r('app.color.color_black') : $r('app.color.color_999999'))
      .fontSize($r('app.float.vp_sixteen'))
      .margin({ left: $r('app.float.vp_eight'), right: $r('app.float.vp_eight') })
  }
}