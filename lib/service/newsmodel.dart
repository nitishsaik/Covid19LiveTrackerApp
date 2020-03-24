class Updated {
  List<News> news;

  Updated({this.news});

  Updated.fromJson(Map<String, dynamic> json) {
    if (json['News'] != null) {
      news = new List<News>();
      json['News'].forEach((v) {
        news.add(new News.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.news != null) {
      data['News'] = this.news.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class News {
  String links;
  String date;
  String news;

  News({this.links, this.date, this.news});

  News.fromJson(Map<String, dynamic> json) {
    links = json['Links'];
    date = json['date'];
    news = json['news'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Links'] = this.links;
    data['date'] = this.date;
    data['news'] = this.news;
    return data;
  }
}