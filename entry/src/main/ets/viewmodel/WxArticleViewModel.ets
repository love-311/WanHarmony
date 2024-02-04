import Constants from '../constants/Constants';
import { httpRequestGet } from '../utils/HttpUtil';
import ResponseResult from '../entity/ResponseResult';
import { Logger } from '../utils/Logger';
import WxArticleAuthorModel from '../entity/WxArticleAuthorModel';
import { PageData } from '../entity/PageData';
import ArticleListModel from '../entity/ArticleListModel';

class WxArticleViewModel {
  //获取公众号作者列表数据
  getWxArticleAuthor(): Promise<WxArticleAuthorModel[]> {
    return new Promise((resolve: Function, reject: Function) => {
      let url = `${Constants.SERVER}/${Constants.GET_WX_ARTICLE_AUTHOR_LIST}`;
      httpRequestGet(url).then((data: ResponseResult) => {
        if (data.errorCode === Constants.SERVER_CODE_SUCCESS) {
          resolve(data.data);
          Logger.error('getWxArticleAuthor success', JSON.stringify(data));
        } else {
          Logger.error('getWxArticleAuthor failed', JSON.stringify(data));
          reject($r('app.string.http_error_message'));
        }
      }).catch((err: Error) => {
        Logger.error('getWxArticleAuthor failed', JSON.stringify(err));
        reject($r('app.string.http_error_message'));
      });
    });
  }

  //获取对应公众号作者的文章列表
  getAuthorArticleList(authorId: string, pageNum: number): Promise<PageData<ArticleListModel>[]> {
    return new Promise((resolve: Function, reject: Function) => {
      let url = `${Constants.SERVER}wxarticle/list/${authorId}/${pageNum}/json`;;
      Logger.error('getAuthorArticleList url', url);
      httpRequestGet(url).then((data: ResponseResult) => {
        if (data.errorCode === Constants.SERVER_CODE_SUCCESS) {
          resolve((data.data as PageData<ArticleListModel>).datas);
          Logger.error('getAuthorArticleList success', JSON.stringify(data));
        } else {
          Logger.error('getAuthorArticleList failed', JSON.stringify(data));
          reject($r('app.string.http_error_message'));
        }
      }).catch((err: Error) => {
        Logger.error('getAuthorArticleList failed', JSON.stringify(err));
        reject($r('app.string.http_error_message'));
      });
    });
  }
}

let wxArticleViewModel = new WxArticleViewModel();

export default wxArticleViewModel as WxArticleViewModel;