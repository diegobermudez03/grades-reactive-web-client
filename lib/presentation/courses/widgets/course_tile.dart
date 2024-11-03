import 'package:flutter/material.dart';
import 'package:reactive_client/repository/entities/course_entity.dart';

class CoursesTable extends StatelessWidget{

  final List<CourseEntity> courses;

  CoursesTable({
    super.key,
    required this.courses
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _getHeader(),
        ..._printCourses(courses)
      ],
    );
  }


  Widget _getHeader(){
    return const Row(
      children: [
        Text("Materia"),
        Text("Profesor"),
        Text("Codigo curso"),
        Text("Acciones")
      ],
    );
  }

  List<Widget> _printCourses(List<CourseEntity> courses){
    return courses.map((entity)=>
        Row(
          children: [
            Text(entity.materia.name),
            Text('${entity.teacher.name} ${entity.teacher.lastName}'),
            Text(entity.code),
            TextButton(onPressed: (){}, child: Text('Ver estudiantes'))
          ],
        )
    ).toList();
  }
}