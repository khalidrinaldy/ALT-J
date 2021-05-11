import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
class Task {
  final String task_name, course;
  final Timestamp deadline;
  final bool;
  Task(this.task_name, this.course, this.deadline, this.bool);
}

class TaskModel {
  final String task_name, course;
  final Timestamp deadline;
  final bool;
  TaskModel({this.task_name, this.course, this.deadline, this.bool});

  factory TaskModel.fromJson(Map json) => TaskModel(
    task_name: json['task_name'],
    course: json['course'],
    deadline: json['deadline'],
    bool: json['bool'],
  );

  Map toJson() => {
    'task_name': task_name,
    'course': course,
    'deadline': deadline,
    'bool': bool,
  };
}

TaskModel taskModelFromJson(String str) => taskModelFromJson(json.decode(str));
String taskModelToJson(TaskModel data) => json.encode(data.toJson());