
class TbManageModel {
  String course;
  String classes;
  String time;

  TbManageModel(
      {required this.course,
      required this.classes,
      required this.time});

  static List<TbManageModel> getUsers() {
    return <TbManageModel>[
      TbManageModel(course: "CSE102", classes: "LRM C13", time: "8:00am-9:00am"),
       TbManageModel(course: "CSE102", classes: "LRM C13", time: "8:00am-9:00am"),
        TbManageModel(course: "CSE102", classes: "LRM C13", time: "8:00am-9:00am"),
         TbManageModel(course: "CSE102", classes: "LRM C13", time: "8:00am-9:00am"),
          TbManageModel(course: "CSE102", classes: "LRM C13", time: "8:00am-9:00am"),
           TbManageModel(course: "CSE102", classes: "LRM C13", time: "8:00am-9:00am")

         ];
  }
}
