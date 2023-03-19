class BlogsDetailsModel {
  bool? success;
  String? message;
  BlogsDetails? data;

  BlogsDetailsModel({this.success, this.message, this.data});

  BlogsDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new BlogsDetails.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class BlogsDetails {
  int? id;
  int? articleCategoryId;
  String? title;
  String? slug;
  String? content;
  String? image;
  List<String>? tags;
  bool? published;
  String? seoTitle;
  String? seoDescription;
  String? seoKeywords;
  String? createdAt;
  String? updatedAt;
  int? date;
  ArticleCategory? articleCategory;

  BlogsDetails(
      {this.id,
      this.articleCategoryId,
      this.title,
      this.slug,
      this.content,
      this.image,
      this.tags,
      this.published,
      this.seoTitle,
      this.seoDescription,
      this.seoKeywords,
      this.createdAt,
      this.updatedAt,
      this.date,
      this.articleCategory});

  BlogsDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    articleCategoryId = json['article_category_id'];
    title = json['title'];
    slug = json['slug'];
    content = json['content'];
    image = json['image'];
    tags = json['tags'].cast<String>();
    published = json['published'];
    seoTitle = json['seo_title'];
    seoDescription = json['seo_description'];
    seoKeywords = json['seo_keywords'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    date = json['date'];
    articleCategory = json['article_category'] != null
        ? new ArticleCategory.fromJson(json['article_category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['article_category_id'] = this.articleCategoryId;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['content'] = this.content;
    data['image'] = this.image;
    data['tags'] = this.tags;
    data['published'] = this.published;
    data['seo_title'] = this.seoTitle;
    data['seo_description'] = this.seoDescription;
    data['seo_keywords'] = this.seoKeywords;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['date'] = this.date;
    if (this.articleCategory != null) {
      data['article_category'] = this.articleCategory!.toJson();
    }
    return data;
  }
}

class ArticleCategory {
  int? id;
  String? name;
  String? slug;
  Null? description;
  String? createdAt;
  String? updatedAt;

  ArticleCategory(
      {this.id,
      this.name,
      this.slug,
      this.description,
      this.createdAt,
      this.updatedAt});

  ArticleCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
