/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import http from '@ohos.net.http';
import { PostData } from '../entity/PostData';
import ResponseResult from '../entity/ResponseResult';
import Constants, { ContentType } from '../constants/Constants';
import { Logger } from './Logger';

/**
 * Initiate an HTTP GET request to the specified URL.
 *
 * @param url URL for initiating an HTTP request.
 */
export function httpRequestGet(url: string) {
  return httpRequest(url, http.RequestMethod.GET);
}

/**
 * Initiate an HTTP POST request to the specified URL.
 *
 * @param url URL for initiating an HTTP request
 * @param postParam Additional data of the request
 * @returns
 */
export function httpRequestPost(url: string, postParam: PostData) {
  return httpRequest(url, http.RequestMethod.POST, postParam);
}

/**
 * Initiates an HTTP request to a given URL.
 *
 * @param url URL for initiating an HTTP request
 * @param method Request method.
 * @param extraData Additional data of the request.
 * @returns Returns {@link ResponseResult}.
 */
function httpRequest(url: string, method: http.RequestMethod, params?: PostData): Promise<ResponseResult> {
  let httpRequest = http.createHttp();
  Logger.error("HTTP POST URL:" + url)
  Logger.error("HTTP POST PARAMS:" + JSON.stringify(params))
  let responseResult = httpRequest.request(url, {
    method: method,
    readTimeout: Constants.HTTP_READ_TIMEOUT,
    header: {
      'Content-Type': ContentType.JSON
    },
    connectTimeout: Constants.HTTP_READ_TIMEOUT,
    extraData: JSON.stringify(params)
  });
  let serverData = new ResponseResult();
  // Processes the data and returns.
  return responseResult.then((value: http.HttpResponse) => {
    Logger.error("HTTP POST value:" + JSON.stringify(value.result))
    if (value.responseCode === Constants.HTTP_CODE_200) {
      // Obtains the returned data.
      let result = `${value.result}`;
      let resultJson: ResponseResult = JSON.parse(result);
      if (resultJson.errorCode === Constants.SERVER_CODE_SUCCESS) {
        serverData.data = resultJson.data;
      }
      serverData.errorCode = resultJson.errorCode;
      serverData.errorMsg = resultJson.errorMsg;
    } else {
      serverData.errorMsg = `${$r('app.string.http_error_message')}&${value.responseCode}`;
      Logger.error("HTTP POST errorMsg:" + JSON.stringify(serverData))
    }
    return serverData;
  }).catch(() => {
    serverData.errorMsg = $r('app.string.http_error_message');
    Logger.error("HTTP POST errorMsg:" + serverData)
    return serverData;
  });
}