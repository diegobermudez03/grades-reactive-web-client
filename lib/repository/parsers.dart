import 'package:reactive_client/repository/entities/course_entity.dart';
import 'package:reactive_client/repository/entities/materia_entity.dart';
import 'package:reactive_client/repository/entities/teacher_entity.dart';

CourseEntity jsonToCourseEntity(Map<String, dynamic> json){
  return CourseEntity(
    json["id"], 
    jsonToMateriaEntity(json["materia"]), 
    jsonToTeacherEntity(json["profesor"]), 
    json["codigo"], 
    DateTime.parse(json["fecha_inicio"]),
    DateTime.parse(json["fecha_fin"]), 
  );
}

MateriaEntity jsonToMateriaEntity(Map<String, dynamic> json){
  return MateriaEntity(
    json["id"], 
    json["nombre"], 
    int.parse(json["creditos"])
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