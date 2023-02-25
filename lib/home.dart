import 'package:flutter/material.dart';
import 'package:notes/sql.dart';

import 'add_notes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SqlDb sqlDb = SqlDb();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddNotes()));
          //Navigator.of(context).pushNamed("addNotes");
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                int response = await sqlDb.insertData(
                    'INSERT INTO "notes"("note") VALUES ("note one")');
                print("response");
              },
              child: const Text("INSERT"),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                List<Map> response =
                    await sqlDb.readData("SELECT * FROM 'notes' ");
                print("$response");
              },
              child: const Text("READ"),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                int response =
                    await sqlDb.deleteData("DELETE FROM 'notes' WHERE id= 2");
                print("$response");
              },
              child: const Text("DELETE"),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                int response = await sqlDb.updateData(
                    "UPDATE 'notes' SET 'note'='note six' WHERE id=6 ");
                print("$response");
              },
              child: const Text("UPDATE"),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                int response = await sqlDb.myDeleteDataBase();
                print("$response");
              },
              child: const Text("Delete All DataBase"),
            ),
          ],
        ),
      ),
    );
  }
}
