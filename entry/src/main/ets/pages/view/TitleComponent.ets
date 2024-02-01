import router from '@ohos.router'

@Component
export struct TitleComponent {
  title: string = ""
  back: () => void = () => {
    router.back()
  }

  build() {
    Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
      Image($r('app.media.ic_public_back'))
        .width($r('app.float.vp_twenty_four'))
        .height($r('app.float.vp_twenty_four'))
        .onClick(() => {
          this.back()
        })

      Text(this.title)
        .fontSize($r('app.float.big_font_size'))
        .maxLines(1)
        .padding({ left: $r('app.float.vp_twelve'), right: $r('app.float.vp_twelve') })
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .align(Alignment.Center)
        .textAlign(TextAlign.Center)

      //放一个空白控件，让title居中
      Divider()
        .width('10%').height('0')
    }
    .width('100%')
    .padding(16)
  }
}