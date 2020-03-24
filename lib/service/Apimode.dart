class Details {
  List<Corona> corona;

  Details({this.corona});

  Details.fromJson(Map<String, dynamic> json) {
    if (json['Corona'] != null) {
      corona = new List<Corona>();
      json['Corona'].forEach((v) {
        corona.add(new Corona.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.corona != null) {
      data['Corona'] = this.corona.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Corona {
  String activeCases;
  String average;
  String code;
  String country;
  String newCases;
  String newDeaths;
  String serious;
  String totalCases;
  String totalDeaths;
  String totalRecoverd;

  Corona(
      {this.activeCases,
      this.average,
      this.code,
      this.country,
      this.newCases,
      this.newDeaths,
      this.serious,
      this.totalCases,
      this.totalDeaths,
      this.totalRecoverd});

  Corona.fromJson(Map<String, dynamic> json) {
    activeCases = json['ActiveCases'];
    average = json['Average'];
    code = json['Code'];
    country = json['Country'];
    newCases = json['NewCases'];
    newDeaths = json['NewDeaths'];
    serious = json['Serious'];
    totalCases = json['TotalCases'];
    totalDeaths = json['TotalDeaths'];
    totalRecoverd = json['TotalRecoverd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ActiveCases'] = this.activeCases;
    data['Average'] = this.average;
    data['Code'] = this.code;
    data['Country'] = this.country;
    data['NewCases'] = this.newCases;
    data['NewDeaths'] = this.newDeaths;
    data['Serious'] = this.serious;
    data['TotalCases'] = this.totalCases;
    data['TotalDeaths'] = this.totalDeaths;
    data['TotalRecoverd'] = this.totalRecoverd;
    return data;
  }
}
