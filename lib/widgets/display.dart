// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../models/employee_convert.dart';

class Display extends StatelessWidget {
  final ref = FirebaseDatabase.instance.reference().child('Task/');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        const Center(
          child: Text(
            "Employee List",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
        ),
        const Divider(
          indent: 15,
          endIndent: 15,
          thickness: 2,
          color: Colors.black,
        ),
        const SizedBox(
          height: 25,
        ),
        SingleChildScrollView(
          child: Center(
            child: FirebaseAnimatedList(
                shrinkWrap: true,
                query: ref,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation animation, int index) {
                  var employee = json.encode(snapshot.value);
                  var data = employeeConvertFromJson(employee).toJson();
                  return (int.parse(data["Experience"].toString()) < 5)
                      ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: Colors.red,
                                  child: const Icon(Icons.star_border),
                                ),
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: (() =>
                                  ref.child(snapshot.key!).remove()),
                              icon: const Icon(Icons.delete),
                            ),
                            title: Text(
                              "Name : ${data["Name"]} \nExperience: ${data["Experience"]} ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: Colors.green,
                                  child: const Icon(Icons.star),
                                ),
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: (() =>
                                  ref.child(snapshot.key!).remove()),
                              icon: const Icon(Icons.delete),
                            ),
                            title: Text(
                              "Name : ${data["Name"]} \nExperience: ${data["Experience"]} ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ),
                        );
                }),
          ),
        ),
      ],
    );
  }
}
