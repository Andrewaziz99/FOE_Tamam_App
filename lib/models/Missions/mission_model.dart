class MissionModel{
  String? id;
  String? soldierId;
  String? soldierFunction1;
  String? soldierFunction2;
  String? date;

  MissionModel(this.id, this.soldierId, this.soldierFunction1,
      this.soldierFunction2, this.date);

  MissionModel.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    soldierId = json['soldierId'];
    soldierFunction1 = json['soldierFunction1'];
    soldierFunction2 = json['soldierFunction2'];
    date = json['date'];
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id.toString(),
      'soldierId': soldierId,
      'soldierFunction1': soldierFunction1,
      'soldierFunction2': soldierFunction2,
      'date': date
    };
  }

}
