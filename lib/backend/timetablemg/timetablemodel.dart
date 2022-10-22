// ignore_for_file: prefer_collection_literals

class TimeTable {
  int? id;
  String? title;
  String? coursecode;
  String? day;
  DateTime? starttime;
  String? endtime;
  int? color;
  int? remind;
  String? repeat;
  TimeTable(
      {this.color,
      this.endtime,
      this.id,
      this.day,
      this.coursecode,
      this.remind,
      this.repeat,
      required this.starttime,
      this.title});
  TimeTable.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    color = json["color"];
    day = json['day'];
    endtime = json["endtime"];
    coursecode = json["coursecode"];
    remind = json["remind"];
    repeat = json["repeat"];
    starttime = DateTime.tryParse(json["starttime"]);
    title = json["title"];
  }

  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["color"] = color;
    data["endtime"] = endtime;
    data['day'] = day;
    data["coursecode"] = coursecode;
    data["remind"] = remind;
    data["repeat"] = repeat;
    data["starttime"] = starttime!.toIso8601String();
    data["title"] = title;

    return data;
  }
}
