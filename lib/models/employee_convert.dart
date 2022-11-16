// To parse this JSON data, do
//
//     final employeeConvert = employeeConvertFromJson(jsonString);

import 'dart:convert';

EmployeeConvert employeeConvertFromJson(String str) =>
    EmployeeConvert.fromJson(json.decode(str));

String employeeConvertToJson(EmployeeConvert data) =>
    json.encode(data.toJson());

class EmployeeConvert {
  EmployeeConvert({
    required this.experience,
    required this.name,
  });

  int experience;
  String name;

  factory EmployeeConvert.fromJson(Map<String, dynamic> json) =>
      EmployeeConvert(
        experience: json["Experience"],
        name: json["Name"],
      );

  Map<String, dynamic> toJson() => {
        "Experience": experience,
        "Name": name,
      };
}
