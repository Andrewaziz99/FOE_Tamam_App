class VacationModel {
  String? Id;
  String? soldierId;
  String? name;
  String? rank;
  String? fromDate;
  String? toDate;
  String? feedback;
  String? city;
  String? lastVac;

  VacationModel(this.Id, this.soldierId, this.name, this.rank, this.fromDate,
      this.toDate, this.feedback, this.city, this.lastVac);

  VacationModel.fromJson(Map<dynamic, dynamic> json) {
    Id = json['Id'];
    soldierId = json['soldierId'];
    name = json['name'];
    rank = json['rank'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    feedback = json['feedback'];
    city = json['city'];
    lastVac = json['lastVac'];
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': Id,
      'soldierId': soldierId,
      'name': name,
      'rank': rank,
      'fromDate': fromDate,
      'toDate': toDate,
      'feedback': feedback,
      'city': city,
      'lastVac': lastVac
    };
  }
}
