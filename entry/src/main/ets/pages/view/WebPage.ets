import router from '@ohos.router'
import webview from '@ohos.web.webview'
import { TitleComponent } from './TitleComponent'
import promptAction from '@ohos.promptAction'
import { Logger } from '../../utils/Logger'
import { WebParam } from '../../entity/WebParam'
import { StyleConstants } from '../../constants/StyleConstants'


@Entry
@Component
struct WebPage {
  controller: webview.WebviewController = new webview.WebviewController()
  @State webParam: WebParam = router.getParams() as WebParam
  @State isLoading: boolean = true;
  @State progressVal: number = 0;

  build() {
    Column() {
      TitleComponent({ title: this.webParam.title, back: () => {
        Logger.error(this.webParam.title)
        if (this.controller.accessBackward()) {
          this.controller.backward()
        } else {
          router.back()
        }
      } })
      if (this.isLoading) {
        Progress({ value: this.progressVal, total: 100, type: ProgressType.Linear }).width(StyleConstants.FULL_WIDTH)
      }
      Web({ src: this.webParam.url, controller: this.controller })
        .javaScriptAccess(true)
        .onlineImageAccess(true)
        .onProgressChange(event=>{
          this.progressVal = event.newProgress
        })
        .onPageEnd(() => {
          this.isLoading = false;
          Logger.info(`onPageEnd: ${this.webParam.url}`)
        })
        .onErrorReceive((event) => {
          promptAction.showToast({
            message: `onErrorReceive: ${event.error.getErrorInfo()}`,
            duration: 1000
          })
        })
        .width('100%')
        .height('100%')
    }
  }
}