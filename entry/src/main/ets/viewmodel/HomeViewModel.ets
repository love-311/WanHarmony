import Constants from '../constants/Constants';
import { httpRequestGet } from '../utils/HttpUtil';
import ResponseResult from '../entity/ResponseResult';
import HomeBannerModel from '../entity/HomeBannerModel';
import { Logger } from '../utils/Logger';
import ArticleListModel from '../entity/ArticleListModel';
import { PageData } from '../entity/PageData';

const DEFAULT_HOME_DATA: HomeBannerModel[] = [
  new HomeBannerModel("我们支持订阅啦~", 30, "https://www.wanandroid.com/blogimgs/42da12d8-de56-4439-b40c-eab66c227a4b.png",
    1, 2, "我们支持订阅啦~", 0, "https://www.wanandroid.com/blog/show/3352")
]

class HomeViewModel {
  //网络获取banner数据
  getHomeBanner(): Promise<HomeBannerModel[]> {
    return new Promise((resolve: Function, reject: Function) => {
      let url = `${Constants.SERVER}/${Constants.GET_BANNER_LIST}`;
      httpRequestGet(url).then((data: ResponseResult) => {
        if (data.errorCode === Constants.SERVER_CODE_SUCCESS) {
          resolve(data.data);
          Logger.error('getBannerList success', JSON.stringify(data));
        } else {
          Logger.error('getBannerList failed', JSON.stringify(data));
          resolve(DEFAULT_HOME_DATA);
          reject($r('app.string.http_error_message'));
        }
      }).catch((err: Error) => {
        Logger.error('getBannerList failed', JSON.stringify(err));
        reject($r('app.string.http_error_message'));
      });
    });
  }

  //首页文章列表
  getArticleList(pageNum: number): Promise<PageData<ArticleListModel>[]> {
    return new Promise((resolve: Function, reject: Function) => {
      let url = `${Constants.SERVER}article/list/${pageNum}/json`;
      Logger.error('getArticleList url', url)
      httpRequestGet(url).then((data: ResponseResult) => {
        if (data.errorCode === Constants.SERVER_CODE_SUCCESS) {
          resolve((data.data as PageData<ArticleListModel>).datas);
          Logger.error('getArticleList success', JSON.stringify((data.data as PageData<ArticleListModel>).datas));
        } else {
          Logger.error('getArticleList failed', JSON.stringify(data));
          reject($r('app.string.http_error_message'));
        }
      }).catch((err: Error) => {
        Logger.error('getBannerList failed', JSON.stringify(err));
        reject($r('app.string.http_error_message'));
      });
    });
  }
}

let homeViewModel = new HomeViewModel();

export default homeViewModel as HomeViewModel;