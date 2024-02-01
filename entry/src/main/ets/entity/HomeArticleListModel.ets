export default class HomeArticleListModel {
  adminAdd: boolean
  apkLink: string
  audit: number
  author: string
  canEdit: Boolean
  chapterId: number
  chapterName: string
  collect: boolean
  courseId: number
  desc: string
  descMd: string
  envelopePic: string
  fresh: boolean
  host: string
  id: number
  isAdminAdd: boolean
  link: string
  niceDate: string
  niceShareDate: string
  origin: string
  prefix: string
  projectLink: string
  publishTime: number
  realSuperChapterId: number
  selfVisible: number
  shareDate: number
  shareUser: string
  superChapterId: number
  superChapterName: string
  tags: Array<any>
  title: string
  type: number
  userId: number
  visible: number
  zan: number
  top: boolean = false

  constructor(adminAdd: boolean, apkLink: string, audit: number, author: string, canEdit: Boolean, chapterId: number, chapterName: string, collect: boolean, courseId: number, desc: string, descMd: string, envelopePic: string, fresh: boolean, host: string, id: number, isAdminAdd: boolean, link: string, niceDate: string, niceShareDate: string, origin: string, prefix: string, projectLink: string, publishTime: number, realSuperChapterId: number, selfVisible: number, shareDate: number, shareUser: string, superChapterId: number, superChapterName: string, tags: Array<any>, title: string, type: number, userId: number, visible: number, zan: number) {
    this.adminAdd = adminAdd;
    this.apkLink = apkLink;
    this.audit = audit;
    this.author = author;
    this.canEdit = canEdit;
    this.chapterId = chapterId;
    this.chapterName = chapterName;
    this.collect = collect;
    this.courseId = courseId;
    this.desc = desc;
    this.descMd = descMd;
    this.envelopePic = envelopePic;
    this.fresh = fresh;
    this.host = host;
    this.id = id;
    this.isAdminAdd = isAdminAdd;
    this.link = link;
    this.niceDate = niceDate;
    this.niceShareDate = niceShareDate;
    this.origin = origin;
    this.prefix = prefix;
    this.projectLink = projectLink;
    this.publishTime = publishTime;
    this.realSuperChapterId = realSuperChapterId;
    this.selfVisible = selfVisible;
    this.shareDate = shareDate;
    this.shareUser = shareUser;
    this.superChapterId = superChapterId;
    this.superChapterName = superChapterName;
    this.tags = tags;
    this.title = title;
    this.type = type;
    this.userId = userId;
    this.visible = visible;
    this.zan = zan;
  }
}