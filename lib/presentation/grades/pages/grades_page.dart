import 'package:flutter/material.dart';
import 'package:reactive_client/repository/entities/student_entity.dart';

class GradesPage extends StatelessWidget{

  final StudentEntity student;
  final int courseId;

  GradesPage({
    super.key,
    required this.student,
    required this.courseId
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}