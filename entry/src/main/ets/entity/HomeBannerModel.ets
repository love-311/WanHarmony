export default class HomeBannerModel {
  desc: string;
  id: number;
  imagePath: string;
  isVisible: number;
  order: number;
  title: string;
  type: number;
  url: string;

  constructor(desc: string, id: number, imagePath: string, isVisible: number, order: number, title: string, type: number, url: string) {
    this.desc = desc;
    this.id = id;
    this.imagePath = imagePath;
    this.isVisible = isVisible;
    this.order = order;
    this.title = title;
    this.type = type;
    this.url = url;
  }
}