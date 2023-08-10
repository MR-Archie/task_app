// ignore_for_file: deprecated_member_use

import 'package:firebase_database/firebase_database.dart';
import '../widgets/display.dart';
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
      body: Display(),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => addUser(context)),
        child: const Icon(Icons.add),
      ),
    );
  }
}
