import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite_common/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

void main() {
  // IMPORTANT for Web
  databaseFactory = databaseFactoryFfiWeb;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: DBPage());
  }
}

class DBPage extends StatefulWidget {
  const DBPage({super.key});

  @override
  State<DBPage> createState() => _DBPageState();
}

class _DBPageState extends State<DBPage> {
  Database? db;
  bool isReady = false;
  List<Map<String, dynamic>> students = [];

  final TextEditingController controller = TextEditingController();

  // INIT DB
  Future<void> initDB() async {
    try {
      print("🚀 Starting DB...");

      db = await openDatabase(
        join('student.db'),
        version: 1,
        onCreate: (db, version) async {
          print("📦 Creating table...");
          await db.execute(
            "CREATE TABLE student(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)",
          );
        },
      );

      print("✅ DB Ready");

      setState(() {
        isReady = true;
      });

      fetchData();
    } catch (e) {
      print("❌ DB ERROR: $e");
    }
  }

  // INSERT
  Future<void> addStudent() async {
    try {
      if (controller.text.isEmpty) return;

      await db!.insert('student', {'name': controller.text});

      print("➕ Added: ${controller.text}");

      controller.clear();
      fetchData();
    } catch (e) {
      print("❌ Insert ERROR: $e");
    }
  }

  // FETCH
  Future<void> fetchData() async {
    final data = await db!.query('student');

    print("📋 Data: $data");

    setState(() {
      students = data;
    });
  }

  // DELETE
  Future<void> deleteStudent(int id) async {
    await db!.delete('student', where: 'id = ?', whereArgs: [id]);
    fetchData();
  }

  @override
  void initState() {
    super.initState();
    initDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SQLite Web CRUD")),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: "Enter Name",
                border: OutlineInputBorder(),
              ),
            ),
          ),

          ElevatedButton(
            onPressed: isReady ? addStudent : null,
            child: const Text("Add Student"),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: students.isEmpty
                ? const Center(child: Text("No Data Found"))
                : ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final s = students[index];

                      return ListTile(
                        title: Text(s['name']),
                        leading: Text(s['id'].toString()),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteStudent(s['id']),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
