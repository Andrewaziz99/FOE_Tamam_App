class SoldierModel {
  String? id;
  String? soldierImage;
  String? soldierName;
  String? soldierRank;
  String? soldierId;
  String? soldierPhone;
  String? soldierAddPhone;
  String? soldierHomeAddress;
  String? soldierHomePhone;
  String? soldierBDate;
  String? soldierCity;
  String? soldierNationalId;
  String? soldierJob;
  String? soldierJoinDate;
  String? soldierRetireDate;
  String? soldierFaculty;
  String? soldierSpeciality;
  String? soldierSkills;
  String? soldierFatherJob;
  String? soldierMotherJob;
  String? soldierFatherPhone;
  String? soldierMotherPhone;
  String? soldierGrade;
  String? soldierNumOfSiblings;
  String? soldierFunction;
  String? soldierIdImage;
  String? soldierNationalIdImage;
  int? isOUT = 0;
  int? inVAC = 0;

  SoldierModel(
      this.id,
      this.soldierImage,
      this.soldierName,
      this.soldierRank,
      this.soldierId,
      this.soldierPhone,
      this.soldierAddPhone,
      this.soldierHomeAddress,
      this.soldierHomePhone,
      this.soldierBDate,
      this.soldierCity,
      this.soldierNationalId,
      this.soldierJob,
      this.soldierJoinDate,
      this.soldierRetireDate,
      this.soldierFaculty,
      this.soldierSpeciality,
      this.soldierSkills,
      this.soldierFatherJob,
      this.soldierMotherJob,
      this.soldierFatherPhone,
      this.soldierMotherPhone,
      this.soldierGrade,
      this.soldierNumOfSiblings,
      this.soldierFunction,
      this.soldierIdImage,
      this.soldierNationalIdImage,
      this.isOUT,
      this.inVAC
      );

  SoldierModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'].toString();
    soldierImage = json['soldierImage'];
    soldierName = json['soldierName'];
    soldierRank = json['soldierRank'];
    soldierId = json['soldierId'];
    soldierPhone = json['soldierPhone'];
    soldierAddPhone = json['soldierAddPhone'];
    soldierHomeAddress = json['soldierHomeAddress'];
    soldierHomePhone = json['soldierHomePhone'];
    soldierBDate = json['soldierBDate'];
    soldierCity = json['soldierCity'];
    soldierNationalId = json['soldierNationalId'];
    soldierJob = json['soldierJob'];
    soldierJoinDate = json['soldierJoinDate'];
    soldierRetireDate = json['soldierRetireDate'];
    soldierFaculty = json['soldierFaculty'];
    soldierSpeciality = json['soldierSpeciality'];
    soldierSkills = json['soldierSkills'];
    soldierFatherJob = json['soldierFatherJob'];
    soldierMotherJob = json['soldierMotherJob'];
    soldierFatherPhone = json['soldierFatherPhone'];
    soldierMotherPhone = json['soldierMotherPhone'];
    soldierGrade = json['soldierGrade'];
    soldierNumOfSiblings = json['soldierNumOfSiblings'];
    soldierFunction = json['soldierFunction'];
    soldierIdImage = json['soldierIdImage'];
    soldierNationalIdImage = json['soldierNationalIdImage'];
    isOUT = json['isOUT'];
    inVAC = json['inVAC'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id.toString(),
      'soldierImage': soldierImage,
      'soldierName': soldierName,
      'soldierRank': soldierRank,
      'soldierId': soldierId,
      'soldierPhone': soldierPhone,
      'soldierAddPhone': soldierAddPhone,
      'soldierHomeAddress': soldierHomeAddress,
      'soldierHomePhone': soldierHomePhone,
      'soldierBDate': soldierBDate,
      'soldierCity': soldierCity,
      'soldierNationalId': soldierNationalId,
      'soldierJob': soldierJob,
      'soldierJoinDate': soldierJoinDate,
      'soldierRetireDate': soldierRetireDate,
      'soldierFaculty': soldierFaculty,
      'soldierSpeciality': soldierSpeciality,
      'soldierSkills': soldierSkills,
      'soldierFatherJob': soldierFatherJob,
      'soldierMotherJob': soldierMotherJob,
      'soldierFatherPhone': soldierFatherPhone,
      'soldierMotherPhone': soldierMotherPhone,
      'soldierGrade': soldierGrade,
      'soldierNumOfSiblings': soldierNumOfSiblings,
      'soldierFunction': soldierFunction,
      'soldierIdImage': soldierIdImage,
      'soldierNationalIdImage': soldierNationalIdImage,
      'isOUT': isOUT,
      'inVAC': inVAC,
    };
  }
}
