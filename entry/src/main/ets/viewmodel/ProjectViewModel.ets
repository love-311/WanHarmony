import Constants from '../constants/Constants';
import { httpRequestGet } from '../utils/HttpUtil';
import ResponseResult from '../entity/ResponseResult';
import { Logger } from '../utils/Logger';
import ProjectTagModel from '../entity/ProjectTagModel';
import { PageData } from '../entity/PageData';
import ArticleListModel from '../entity/ArticleListModel';

class ProjectViewModel {
  //获取项目分类
  getProjectTag(): Promise<ProjectTagModel[]> {
    return new Promise((resolve: Function, reject: Function) => {
      let url = `${Constants.SERVER}/${Constants.GET_PROJECT_TAG_LIST}`;
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

  //分类下项目列表数据
  getProjectArticleList(cid: string, pageNum: number): Promise<PageData<ArticleListModel>[]> {
    return new Promise((resolve: Function, reject: Function) => {
      let url = `${Constants.SERVER}project/list/${pageNum}/json?cid=${cid}`
      Logger.error('getProjectArticleList url', url);
      httpRequestGet(url).then((data: ResponseResult) => {
        if (data.errorCode === Constants.SERVER_CODE_SUCCESS) {
          resolve((data.data as PageData<ArticleListModel>).datas);
          Logger.error('getProjectArticleList success', JSON.stringify(data));
        } else {
          Logger.error('getProjectArticleList failed', JSON.stringify(data));
          reject($r('app.string.http_error_message'));
        }
      }).catch((err: Error) => {
        Logger.error('getProjectArticleList failed', JSON.stringify(err));
        reject($r('app.string.http_error_message'));
      });
    });
  }
}

let projectViewModel = new ProjectViewModel();

export default projectViewModel as ProjectViewModel;