class Andhra {
  List<StateWise> stateWise;

  Andhra({this.stateWise});

  Andhra.fromJson(Map<String, dynamic> json) {
    if (json['StateWise'] != null) {
      stateWise = new List<StateWise>();
      json['StateWise'].forEach((v) {
        stateWise.add(new StateWise.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stateWise != null) {
      data['StateWise'] = this.stateWise.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StateWise {
  String deaths;
  String discharged;
  String foreignNational;
  String indianNational;
  String state;

  StateWise(
      {this.deaths,
      this.discharged,
      this.foreignNational,
      this.indianNational,
      this.state});

  StateWise.fromJson(Map<String, dynamic> json) {
    deaths = json['Deaths'];
    discharged = json['Discharged'];
    foreignNational = json['ForeignNational'];
    indianNational = json['IndianNational'];
    state = json['State'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Deaths'] = this.deaths;
    data['Discharged'] = this.discharged;
    data['ForeignNational'] = this.foreignNational;
    data['IndianNational'] = this.indianNational;
    data['State'] = this.state;
    return data;
  }
}