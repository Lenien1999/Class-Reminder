// ignore_for_file: prefer_collection_literals

class Task {
  int? id;
  String? title;
  String? note;
  String? date;
    DateTime ?starttime;
 String?  endtime;
  int? color;
  int? remind;
  String? repeat;
  Task(
      {this.color,
      this.date,
      this.endtime,
      this.id,
      this.note,
      this.remind,
      this.repeat,
      required this.starttime,
      this.title});
  Task.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    color = json["color"];
    date = json["date"];
    endtime = json["endtime"];
    note = json["note"];
    remind = json["remind"];
    repeat = json["repeat"];
    starttime =DateTime.tryParse(json["starttime"] );
    title = json["title"];
  }

  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["color"] = color;
    data["endtime"] = endtime;
    data["date"] = date;
    data["note"] = note;
    data["remind"] = remind;
    data["repeat"] = repeat;
    data["starttime"] = starttime!.toIso8601String();
    data["title"] = title;

    return data;
  }
}
