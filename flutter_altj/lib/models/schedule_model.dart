import 'dart:convert';
class Schedule {
  final String course, lecture, day, from, to;
  Schedule(this.course, this.lecture, this.day, this.from, this.to);
}

class ScheduleModel {
  final String course, lecture, day, from, to;
  ScheduleModel({this.course, this.lecture, this.day, this.from, this.to});

  factory ScheduleModel.fromJson(Map json) => ScheduleModel(
    course: json['course'],
    lecture: json['lecture'],
    day: json['day'],
    from: json['from'],
    to: json['to'],
  );

  Map toJson() => {
    'course': course,
    'lecture': lecture,
    'day': day,
    'from': from,
    'to': to,
  };
}

ScheduleModel scheduleModelFromJson(String str) => scheduleModelFromJson(json.decode(str));
String scheduleModelToJson(ScheduleModel data) => json.encode(data.toJson());