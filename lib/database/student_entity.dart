import 'package:floor/floor.dart';

@Entity(tableName: 'students')
class Student {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String name;
  final String rollno;
  final String course;

  Student({
    this.id,
    required this.name,
    required this.rollno,
    required this.course,
  });

  @override
  String toString() {
    return 'Student{id: $id, name: $name, rollno: $rollno, course: $course}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Student &&
        other.id == id &&
        other.name == name &&
        other.rollno == rollno &&
        other.course == course;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ rollno.hashCode ^ course.hashCode;
  }
}
