/*
 *  Copyright (c) 2023 Huawei Device Co., Ltd.
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  http://www.apache.org/licenses/LICENSE-2.0
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

export default class Constants {
  /**
   * The host address of the server.
   */
  static readonly SERVER: string = 'https://www.wanandroid.com/';

  /**
   * 获取首页banner列表数据
   */
  static readonly GET_BANNER_LIST: string = 'banner/json';

  /**
   * 获取置顶文章数据
   */
  static readonly GET_TOP_ARTICLE_LIST: string = 'article/top/json';

  /**
   * 获取首页文章列表数据
   */
  static readonly GET_ARTICLE_LIST: string = 'article/list/${pageNumber}/json';

  /**
   * 获取所有公众号作者列表数据
   */
  static readonly GET_WX_ARTICLE_AUTHOR_LIST: string = 'wxarticle/chapters/json';

  /**
   * 获取项目标签列表
   */
  static readonly GET_PROJECT_TAG_LIST: string = 'project/tree/json';

  /**
   * The request success status code.
   */
  static readonly SERVER_CODE_SUCCESS: number = 0;

  /**
   * The page size.
   */
  static readonly PAGE_SIZE: number = 20;

  /**
   * Http request success status code.
   */
  static readonly HTTP_CODE_200: number = 200;

  /**
   * The delay time.
   */
  static readonly DELAY_TIME: number = 1000;

  /**
   * The animation duration.
   */
  static readonly ANIMATION_DURATION: number = 300;

  /**
   * The http timeout duration.
   */
  static readonly HTTP_READ_TIMEOUT: number = 10000;
}

/**
 * The request content type enum.
 */
export const enum ContentType {
  JSON = 'application/json',
  FORM = 'multipart/form-data'
}