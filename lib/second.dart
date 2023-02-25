import 'package:flutter/material.dart';
import 'package:notes/sql.dart';

import 'edit_notes.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  SqlDb sqlDb = SqlDb();
  bool isLoading = true;
  List notes = [];
  Future readData() async {
    List<Map> response = await sqlDb.readData(" SELECT * FROM `notes` ");
    notes.addAll(response);
    isLoading = false;
    if (this.mounted) {
      setState(() {});
    }
    return response;
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("homePage")),
        body: isLoading == true
            ? const Center(child: Text("Loading...."))
            : Container(
                child: ListView(
                children: [
                  ListView.builder(
                      itemCount: notes.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return Card(
                            child: ListTile(
                                title: Text("${notes[i]['title']}"),
                                subtitle: Text("${notes[i]['note']}"),
                                trailing: Row(
                                  children: [
                                    IconButton(
                                      //remove from database
                                      onPressed: () async {
                                        int response = await sqlDb.deleteData(
                                            "DELETE FROM `notes` WHERE `id`= ${notes[i]['id']} ");
                                        //remove from ui
                                        if (response > 0) {
                                          notes.removeWhere((element) =>
                                              element['id'] == notes[i]);
                                          setState(() {});
                                        }
                                      },
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                    ),
                                    IconButton(
                                      //remove from database
                                      onPressed: () async {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditeNotes(
                                                      color: notes[i]['color'],
                                                      note: notes[i]['note'],
                                                      title: notes[i]['title'],
                                                      id: notes[i]['id'],
                                                    )));
                                      },
                                      icon: const Icon(Icons.edit,
                                          color: Colors.blue),
                                    ),
                                  ],
                                )
                                //trailing: Text("${snapshot.data![i]['color']}"),
                                ));
                      })
                ],
              )));
  }
}
