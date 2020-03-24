class India {
  List<Stats> stats;

  India({this.stats});

  India.fromJson(Map<String, dynamic> json) {
    if (json['Stats'] != null) {
      stats = new List<Stats>();
      json['Stats'].forEach((v) {
        stats.add(new Stats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stats != null) {
      data['Stats'] = this.stats.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stats {
  String activeIndia;
  String cured;
  String death;
  String links;
  String news;
  String screend;
  String date;
  String migration;

  Stats(
      {this.activeIndia,
      this.cured,
      this.death,
      this.links,
      this.news,
      this.screend,
      this.date,
      this.migration});

  Stats.fromJson(Map<String, dynamic> json) {
    activeIndia = json['ActiveIndia'];
    cured = json['Cured'];
    death = json['Death'];
    links = json['Links'];
    news = json['News'];
    screend = json['Screend'];
    date = json['date'];
    migration = json['migration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ActiveIndia'] = this.activeIndia;
    data['Cured'] = this.cured;
    data['Death'] = this.death;
    data['Links'] = this.links;
    data['News'] = this.news;
    data['Screend'] = this.screend;
    data['date'] = this.date;
    data['migration'] = this.migration;
    return data;
  }
}
