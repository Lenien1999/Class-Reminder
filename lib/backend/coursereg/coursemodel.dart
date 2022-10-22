// class CourseData {
//     String courseFee;
//     String courseName;
//     String duration;
//     String instructorName;
//     String studentId;

//     CourseData({this.courseFee, this.courseName, this.duration, this.instructorName, this.studentId});

//     factory CourseData.fromJson(Map<String, dynamic> json) {
//         return CourseData(
//             courseFee: json['courseFee'],
//             courseName: json['courseName'],
//             duration: json['duration'],
//             instructorName: json['instructorName'],
//             studentId: json['studentId'],
//         );
//     }

//     Map<String, dynamic> toJson() {
//         final Map<String, dynamic> data = new Map<String, dynamic>();
//         data['courseFee'] = this.courseFee;
//         data['courseName'] = this.courseName;
//         data['duration'] = this.duration;
//         data['instructorName'] = this.instructorName;
//         data['studentId'] = this.studentId;
//         return data;
//     }
// }