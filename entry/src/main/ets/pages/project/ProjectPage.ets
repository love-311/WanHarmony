import Constants from '../../constants/Constants'
import { StyleConstants } from '../../constants/StyleConstants'
import ProjectTagModel from '../../entity/ProjectTagModel'
import ProjectViewModel from '../../viewmodel/ProjectViewModel'
import { ProjectListView } from './ProjectListView'

@Component
export struct ProjectPage {
  @State projectTag: ProjectTagModel[] = []
  @State currentTabIndex: number = 0
  private tabsController: TabsController = new TabsController()

  build() {
    Flex() {
      Column() {
        Tabs({ barPosition: BarPosition.Start, index: this.currentTabIndex, controller: this.tabsController }) {
          ForEach(this.projectTag, (item: ProjectTagModel, index: number) => {
            TabContent() {
              ProjectListView({ projectTag: item })
            }.tabBar(this.tabBuilder(index))
          }, (item: ProjectTagModel) => {
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
    this.getProjectTag()
  }

  getProjectTag() {
    ProjectViewModel.getProjectTag().then(
      (wxArticleAuthorList: ProjectTagModel[]) => {
        this.projectTag = wxArticleAuthorList
      })
  }

  @Builder
  tabBuilder(index: number) {
    Text(this.projectTag[index].name)
      .fontColor(this.currentTabIndex == index ? $r('app.color.color_black') : $r('app.color.color_999999'))
      .fontSize($r('app.float.vp_sixteen'))
      .margin({ left: $r('app.float.vp_eight'), right: $r('app.float.vp_eight') })
  }
}