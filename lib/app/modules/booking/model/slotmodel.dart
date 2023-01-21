class SlotModel {
  DateTime? dateTime;
  String? month;
  String? weekDay;
  String? dayName;

  SlotModel({this.dateTime, this.month, this.weekDay, this.dayName});

  SlotModel.fromJson(Map<dynamic, dynamic> json) {
    dateTime = json['dateTime'];
    month = json['month'];
    weekDay = json['weekDay'];
    dayName = json['dayName'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['dateTime'] = dateTime;
    data['month'] = month;
    data['weekDay'] = weekDay;
    data['dayName'] = dayName;
    return data;
  }
}
