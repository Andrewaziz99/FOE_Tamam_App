class OfficersModel {
  int? id;
  String? officerRank;
  String? officerName;
  String? officerCity;
  String? officerJob;

  OfficersModel(this.id, this.officerRank, this.officerName, this.officerCity, this.officerJob);

  // Make fromJson static
  static OfficersModel fromJson(Map<String, dynamic> json) {
    return OfficersModel(
      json['id'],
      json['rank'],
      json['name'],
      json['city'],
      json['job'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['rank'] = officerRank;
    data['name'] = officerName;
    data['city'] = officerCity;
    data['job'] = officerJob;
    return data;
  }
}