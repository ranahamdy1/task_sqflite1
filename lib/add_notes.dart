import 'package:flutter/material.dart';
import 'package:notes/second.dart';
import 'package:notes/sql.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  SqlDb sqldb = SqlDb();
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("add notes"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Form(
                key: formState,
                child: Column(
                  children: [
                    TextFormField(
                      controller: note,
                      decoration: const InputDecoration(hintText: "note"),
                    ),
                    TextFormField(
                      controller: title,
                      decoration: const InputDecoration(hintText: "note"),
                    ),
                    TextFormField(
                      controller: color,
                      decoration: const InputDecoration(hintText: "note"),
                    ),
                    Container(
                      height: 20,
                    ),
                    MaterialButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () async {
                        int response = await sqldb.insertData(
                            "INSERT INTO `notes`(`note`,`title`, `color`) VALUES ('${note.text}','${title.text}','${color.text}')");
                        if (response > 0) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const SecondScreen()),
                              (route) => false);
                        }
                        print("response");
                        print(response);
                      },
                      child: const Text("Add Note"),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
