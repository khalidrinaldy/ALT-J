import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
class Meeting {
  final String activity, ormawa;
  final Timestamp schedule;
  final bool check;
  Meeting(this.activity, this.ormawa, this.schedule, this.check);
}

class MeetingModel {
  final String activity, ormawa;
  final Timestamp schedule;
  final bool check;
  MeetingModel({this.activity, this.ormawa, this.schedule, this.check});

  factory MeetingModel.fromJson(Map json) => MeetingModel(
    activity: json['activity'],
    ormawa: json['ormawa'],
    schedule: json['schedule'],
    check: json['check'],
  );

  Map toJson() => {
    'activity': activity,
    'ormawa': ormawa,
    'schedule': schedule,
    'check': check,
  };
}

MeetingModel meetingModelFromJson(String str) => meetingModelFromJson(json.decode(str));
String meetingModelToJson(MeetingModel data) => json.encode(data.toJson());