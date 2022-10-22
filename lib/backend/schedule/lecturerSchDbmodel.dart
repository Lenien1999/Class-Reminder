// ignore_for_file: file_names, prefer_collection_literals

class LecturerTask {
  int? id;
  String? course;
  String? note;
  String? date;
   DateTime? starttime;
 String?  endtime;
  int? color;
  String? signaturer;
  LecturerTask(
      {this.color,
      this.date,
      this.endtime,
      this.id,
      this.note,
      this.signaturer,
      required this.starttime,
      this.course});
  LecturerTask.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    color = json["color"];
    date = json["date"];
    endtime = json["endtime"];
    note = json["note"];
    signaturer = json["signaturer"];
    starttime =DateTime.tryParse(json["starttime"] );
    course = json["course"];
  }

  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["color"] = color;
    data["endtime"] = endtime;
    data["date"] = date;
    data["note"] = note;
    data["signaturer"] = signaturer;
    data["starttime"] = starttime!.toIso8601String();
    data["course"] = course;

    return data;
  }
}
