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

export class ButtonInfoModel {
  index: number = 0;
  img: Resource = $r("app.media.tab_home_normal");
  selectImg: Resource = $r('app.media.tab_home_selected');
  title: Resource = $r('app.string.tab_home');
}

const buttonInfo: ButtonInfoModel[] = [
  {
    index: 0,
    img: $r('app.media.tab_home_normal'),
    selectImg: $r('app.media.tab_home_selected'),
    title: $r('app.string.tab_home')
  },
  {
    index: 1,
    img: $r('app.media.tab_wx_article__normal'),
    selectImg: $r('app.media.tab_wx_article_selected'),
    title: $r('app.string.tab_wx_article')
  },
  {
    index: 2,
    img: $r('app.media.tab_search_normal'),
    selectImg: $r('app.media.tab_search_selected'),
    title: $r('app.string.tab_search')
  },
  {
    index: 3,
    img: $r('app.media.tab_project_normal'),
    selectImg: $r('app.media.tab_project_selected'),
    title: $r('app.string.tab_project')
  }
]

export { buttonInfo }