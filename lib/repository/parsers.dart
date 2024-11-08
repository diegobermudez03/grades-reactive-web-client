import 'package:reactive_client/repository/entities/course_entity.dart';
import 'package:reactive_client/repository/entities/grade_entity.dart';
import 'package:reactive_client/repository/entities/materia_entity.dart';
import 'package:reactive_client/repository/entities/student_entity.dart';
import 'package:reactive_client/repository/entities/teacher_entity.dart';

CourseEntity jsonToCourseEntity(Map<String, dynamic> json){
  return CourseEntity(
    json["id"], 
    jsonToMateriaEntity(json["materia"]), 
    jsonToTeacherEntity(json["profesor"]), 
    json["codigo"], 
    DateTime.parse(json["fechaInicio"]),
    DateTime.parse(json["fechaFin"]), 
  );
}

MateriaEntity jsonToMateriaEntity(Map<String, dynamic> json){
  return MateriaEntity(
    json["id"], 
    json["nombre"], 
    json["creditos"]
  );
}

TeacherEntity jsonToTeacherEntity(Map<String, dynamic> json){
  return TeacherEntity(
    json["id"], 
    json["nombre"], 
    json["apellido"], 
    json["correo"]
  );
}

StudentEntity jsonToStudentEntity(Map<String, dynamic> json){
  return StudentEntity(
    json["id"], 
    json["nombre"], 
    json["apellido"], 
    json["correo"]
  );
}

GradeEntity jsonToGradeEntity(Map<String, dynamic> json){
  return GradeEntity(
    json["id"], 
    json["porcentaje"], 
    json["valor"], 
    json["observacion"]
  );
}