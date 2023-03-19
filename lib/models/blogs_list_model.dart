class BlogsListModel {
  bool? success;
  String? message;
  BlogsListing? data;

  BlogsListModel({this.success, this.message, this.data});

  BlogsListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new BlogsListing.fromJson(json['data']) : null;
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

class BlogsListing {
  int? currentPage;
  List<BlogsLst>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

  BlogsListing(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  BlogsListing.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <BlogsLst>[];
      json['data'].forEach((v) {
        data!.add(new BlogsLst.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class BlogsLst {
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

  BlogsLst(
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

  BlogsLst.fromJson(Map<String, dynamic> json) {
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
