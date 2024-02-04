import Constants from '../constants/Constants';
import { httpRequestPost } from '../utils/HttpUtil';
import ResponseResult from '../entity/ResponseResult';
import { Logger } from '../utils/Logger';
import ArticleListModel from '../entity/ArticleListModel';
import { PageData } from '../entity/PageData';
import { PostData } from '../entity/PostData';

class SearchViewModel {
  //搜索画面通过关键字获取列表数据
  getSearchList(keyWords: string, pageNum: number): Promise<PageData<ArticleListModel>[]> {
    return new Promise((resolve: Function, reject: Function) => {
      let url = `${Constants.SERVER}article/query/${pageNum}/json?k=${keyWords}`
      Logger.error('getSearchList url', url)
      let postParam: PostData = new PostData()
      postParam.k = keyWords
      httpRequestPost(url, postParam).then((data: ResponseResult) => {
        if (data.errorCode === Constants.SERVER_CODE_SUCCESS) {
          resolve((data.data as PageData<ArticleListModel>).datas)
          Logger.error('getSearchList success', JSON.stringify((data.data as PageData<ArticleListModel>).datas))
        } else {
          Logger.error('getSearchList failed', JSON.stringify(data))
          reject($r('app.string.http_error_message'));
        }
      }).catch((err: Error) => {
        Logger.error('getSearchList failed', JSON.stringify(err))
        reject($r('app.string.http_error_message'))
      });
    });
  }
}

let searchViewModel = new SearchViewModel()

export default searchViewModel as SearchViewModel