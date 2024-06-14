import 'package:floor/floor.dart';
import 'student_entity.dart';

@dao
abstract class StudentDao {
  @Query('SELECT * FROM students')
  Future<List<Student>> findAllStudents();

  @Query('SELECT * FROM students WHERE id = :id')
  Future<Student?> findStudentById(int id);

  @insert
  Future<void> insertStudent(Student student);

  @update
  Future<void> updateStudent(Student student);

  @delete
  Future<void> deleteStudent(Student student);
}
