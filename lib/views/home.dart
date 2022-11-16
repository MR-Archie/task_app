// ignore_for_file: deprecated_member_use
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import '../models/employee_convert.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  final _nameController = TextEditingController();

  final _experienceController = TextEditingController();

  final ref = FirebaseDatabase.instance.reference().child('Task/');

  void _submitData() {
    final enteredName = _nameController.text;
    final enteredExperience = int.parse(_experienceController.text);

    ref.push().set({"Name": enteredName, "Experience": enteredExperience});

    _nameController.clear();
    _experienceController.clear();

    Navigator.of(context).pop(context);
  }

  void addUser(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return (Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Enter the name of the employee",
                  hintStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
                controller: _nameController,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Enter the amount of experience",
                  hintStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
                keyboardType: TextInputType.number,
                controller: _experienceController,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: (_submitData),
                  child: const Text("Submit Data"),
                ),
              )
            ],
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          "Task  App",
          style: TextStyle(
              wordSpacing: 2, fontSize: 24, fontWeight: FontWeight.w900),
        )),
      ),
      body: Column(
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => addUser(context)),
        child: const Icon(Icons.add),
      ),
    );
  }
}
