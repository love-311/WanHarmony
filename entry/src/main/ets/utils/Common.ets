import router from '@ohos.router';
import { WebParam } from '../entity/WebParam';

export function jumpToWeb(title: string, url: string) {
  router.pushUrl({
    url: "pages/view/WebPage",
    params: new WebParam(title, url)
  }, router.RouterMode.Single)
}