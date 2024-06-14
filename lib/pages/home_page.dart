import 'package:flutter/material.dart';
import 'package:todo/database.dart';
import 'package:todo/database/student_entity.dart';

class HomePage extends StatefulWidget {
  final AppDatabase? database;

  const HomePage({this.database, Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController rollnoController = TextEditingController();
  TextEditingController courseController = TextEditingController();

  List<Student> students = [];

  @override
  void initState() {
    super.initState();
    if (widget.database != null) {
      fetchStudents();
    }
  }

  Future<void> fetchStudents() async {
    if (widget.database != null) {
      final studentList = await widget.database!.studentDao.findAllStudents();
      setState(() {
        students = studentList;
      });
    }
  }

  Future<void> addOrEditStudent({Student? student}) async {
    if (student != null) {
      nameController.text = student.name;
      rollnoController.text = student.rollno;
      courseController.text = student.course;
    } else {
      nameController.clear();
      rollnoController.clear();
      courseController.clear();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 200,
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Name',
                  ),
                ),
                TextField(
                  controller: rollnoController,
                  decoration: const InputDecoration(
                    hintText: 'Roll No',
                  ),
                ),
                TextField(
                  controller: courseController,
                  decoration: const InputDecoration(
                    hintText: 'Course',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                const SizedBox(
                  width: 11,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (widget.database != null) {
                      if (student == null) {
                        final newStudent = Student(
                          name: nameController.text,
                          rollno: rollnoController.text,
                          course: courseController.text,
                        );
                        await widget.database!.studentDao
                            .insertStudent(newStudent);
                      } else {
                        final updatedStudent = Student(
                          id: student.id,
                          name: nameController.text,
                          rollno: rollnoController.text,
                          course: courseController.text,
                        );
                        await widget.database!.studentDao
                            .updateStudent(updatedStudent);
                      }
                      Navigator.pop(context);
                      fetchStudents();
                    }
                  },
                  child: Text(student == null ? 'Save' : 'Update'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteStudent(Student student) async {
    if (widget.database != null) {
      await widget.database!.studentDao.deleteStudent(student);
      fetchStudents();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        title: const Text(
          'Student List',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addOrEditStudent(),
        child: const Icon(Icons.add),
      ),
      body: widget.database == null
          ? const Center(
              child: Text(
                'Database not initialized',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            )
          : students.isEmpty
              ? const Center(
                  child: Text(
                    'Add New Students',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    final student = students[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      child: ListTile(
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () =>
                                  addOrEditStudent(student: student),
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () => deleteStudent(student),
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                        tileColor: Colors.white10,
                        title: Text(
                          student.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Roll No: ${student.rollno}, Course: ${student.course}',
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
