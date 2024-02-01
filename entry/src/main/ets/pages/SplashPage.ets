/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License,Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import router from '@ohos.router';
import { StyleConstants} from '../constants/StyleConstants';
import { Logger} from '../utils/Logger';
import { PageConstants } from '../constants/PageConstants';

@Entry
@Component
struct SplashPage {
  private timeOutId: number = 0;

  build() {
    Flex({direction: FlexDirection.Column, alignItems: ItemAlign.Center}){
      Column() {
        Image($r("app.media.harmony_os"))
          .width( $r('app.float.splash_image_size'))
          .aspectRatio(PageConstants.IMAGE_ASPECT_RATIO)
          .objectFit(ImageFit.Contain)
        Text($r('app.string.splash_desc'))
          .fontColor($r('app.color.forty_alpha_black'))
          .fontSize($r('app.float.bigger_font_size'))
          .margin({ top: $r('app.float.vp_twelve')})
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .flexGrow(StyleConstants.FLEX_GROW)

    }
    .height(StyleConstants.FULL_HEIGHT)
    .width(StyleConstants.FULL_WIDTH)
    .backgroundColor($r('app.color.page_background'))
  }

  aboutToAppear() {
    this.timeOutId = setTimeout(() => {
      router.replaceUrl({ url: PageConstants.MAIN_PAGE_URL })
        .catch((err: Error) => {
          Logger.error(JSON.stringify(err));
        })
    }, PageConstants.DELAY_TIME);
  }

  aboutToDisappear() {
    clearTimeout(this.timeOutId);
  }
}