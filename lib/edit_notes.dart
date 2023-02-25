import 'package:flutter/material.dart';
import 'package:notes/second.dart';
import 'package:notes/sql.dart';

class EditeNotes extends StatefulWidget {
  final note;
  final title;
  final id;
  final color;
  const EditeNotes({Key? key, this.note, this.title, this.id, this.color})
      : super(key: key);

  @override
  State<EditeNotes> createState() => _EditeNotesState();
}

class _EditeNotesState extends State<EditeNotes> {
  SqlDb sqldb = SqlDb();
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  void initState() {
    note.text = widget.note;
    title.text = widget.title;
    color.text = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit notes"),
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
                        int response = await sqldb.updateData(
                            "UPDATE `notes` SET `note`= ${note.text},`title`=${note.text},`color`= ${note.text} WHERE `id`=${widget.id} ");
                        if (response > 0) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const SecondScreen()),
                              (route) => false);
                        }
                        print("response");
                        print(response);
                      },
                      child: const Text("Edit Note"),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
