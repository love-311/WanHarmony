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
import { StyleConstants } from '../constants/StyleConstants';
import { Logger } from '../utils/Logger';
import { PageConstants } from '../constants/PageConstants';

import { HomePage } from '../pages/home/HomePage';
import { WxArticlePage } from '../pages/wxArticle/WxArticlePage';
import { SearchPage } from '../pages/search/SearchPage';
import { ProjectPage } from '../pages/project/ProjectPage';
import { buttonInfo, ButtonInfoModel } from '../entity/MainPageData';


@Entry
@Component
struct MainPage {
  @StorageLink('IndexPage') currentPageIndex: number = 0;

  build() {
    Column() {
      Tabs({
        barPosition: BarPosition.End,
        index: this.currentPageIndex
      }) {
        TabContent() {
          HomePage()
        }
        .tabBar(this.BottomNavigation(buttonInfo[PageConstants.HOME_INDEX]))

        TabContent() {
          WxArticlePage()
        }
        .tabBar(this.BottomNavigation(buttonInfo[PageConstants.WX_ARTICLE_INDEX]))

        TabContent() {
          SearchPage()
        }
        .tabBar(this.BottomNavigation(buttonInfo[PageConstants.SEARCH_INDEX]))

        TabContent() {
          ProjectPage()
        }
        .tabBar(this.BottomNavigation(buttonInfo[PageConstants.PROJECT_INDEX]))
      }
      .barWidth(StyleConstants.FULL_WIDTH)
      .barHeight($r('app.float.vp_fifty_six'))
      .scrollable(false)
      .onChange((index: number) => {
        this.currentPageIndex = index;
      })
    }
    .backgroundColor($r('app.color.page_background'))
  }

  @Builder
  BottomNavigation(button: ButtonInfoModel) {
    Column({ space: PageConstants.BUTTON_SPACE }) {
      Image(this.currentPageIndex === button.index ? button.selectImg : button.img)
        .objectFit(ImageFit.Contain)
        .width($r('app.float.main_image_size'))
        .height($r('app.float.main_image_size'))
      Text(button.title)
        .fontColor(this.currentPageIndex === button.index ? $r('app.color.focus_color') : Color.Black)
        .opacity(this.currentPageIndex === button.index ? StyleConstants.FULL_OPACITY : StyleConstants.SIXTY_OPACITY)
        .fontWeight(StyleConstants.FONT_WEIGHT_FIVE)
        .textAlign(TextAlign.Center)
        .fontSize($r('app.float.micro_font_size'))
    }
    .width(StyleConstants.FULL_WIDTH)
    .height(StyleConstants.FULL_HEIGHT)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}