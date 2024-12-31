class VacationModel {
  String? Id;
  String? soldierId;
  String? name;
  String? rank;
  String? fromDate;
  String? toDate;
  String? feedback;

  VacationModel(this.Id, this.soldierId, this.name, this.rank, this.fromDate,
      this.toDate, this.feedback);

  VacationModel.fromJson(Map<dynamic, dynamic> json) {
    Id = json['Id'];
    soldierId = json['soldierId'];
    name = json['name'];
    rank = json['rank'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    feedback = json['feedback'];
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
    };
  }
}
