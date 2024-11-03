import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reactive_client/repository/entities/course_entity.dart';

class CoursesTable extends StatelessWidget{

  final List<CourseEntity> courses;
  final void Function(BuildContext, CourseEntity) callback;

  CoursesTable({
    super.key,
    required this.courses,
    required this.callback
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _getHeader(),
          ..._printCourses(courses, context)
        ],
      ),
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

  List<Widget> _printCourses(List<CourseEntity> courses, BuildContext context){
    return courses.map((entity)=>
        Row(
          children: [
            Text(entity.materia.name),
            Text('${entity.teacher.name} ${entity.teacher.lastName}'),
            Text(entity.code),
            TextButton(onPressed: ()=>callback(context, entity), child: Text('Ver estudiantes'))
          ],
        )
    ).toList();
  }

}