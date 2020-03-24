class CoronaDetails {
  List<Main> main;

  CoronaDetails({this.main});

  CoronaDetails.fromJson(Map<String, dynamic> json) {
    if (json['Main'] != null) {
      main = new List<Main>();
      json['Main'].forEach((v) {
        main.add(new Main.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.main != null) {
      data['Main'] = this.main.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Main {
  String coronaCases;
  String coronaClose;
  String coronaCritical;
  String coronaCurrent;
  String coronaDeaths;
  String coronaDischarged;
  String coronaMild;
  String recoverd;

  Main(
      {this.coronaCases,
      this.coronaClose,
      this.coronaCritical,
      this.coronaCurrent,
      this.coronaDeaths,
      this.coronaDischarged,
      this.coronaMild,
      this.recoverd});

  Main.fromJson(Map<String, dynamic> json) {
    coronaCases = json['CoronaCases'];
    coronaClose = json['CoronaClose'];
    coronaCritical = json['CoronaCritical'];
    coronaCurrent = json['CoronaCurrent'];
    coronaDeaths = json['CoronaDeaths'];
    coronaDischarged = json['CoronaDischarged'];
    coronaMild = json['CoronaMild'];
    recoverd = json['Recoverd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CoronaCases'] = this.coronaCases;
    data['CoronaClose'] = this.coronaClose;
    data['CoronaCritical'] = this.coronaCritical;
    data['CoronaCurrent'] = this.coronaCurrent;
    data['CoronaDeaths'] = this.coronaDeaths;
    data['CoronaDischarged'] = this.coronaDischarged;
    data['CoronaMild'] = this.coronaMild;
    data['Recoverd'] = this.recoverd;
    return data;
  }
}
