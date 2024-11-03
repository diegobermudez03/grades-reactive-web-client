import 'package:reactive_client/repository/entities/materia_entity.dart';
import 'package:reactive_client/repository/entities/teacher_entity.dart';

class CourseEntity{
  final int id;
  final MateriaEntity materia;
  final TeacherEntity teacher;
  final String code;
  final DateTime startDate;
  final DateTime endDate;

  CourseEntity(this.id, this.materia, this.teacher, this.code, this.startDate, this.endDate);
}
