import 'package:flutter/widgets.dart';
import 'package:reactive_client/repository/entities/student_entity.dart';

class StudentsTable extends StatelessWidget{

  final List<StudentEntity> students;
  final void Function(BuildContext, StudentEntity) callback;

  StudentsTable({
    super.key,
    required this.students,
    required this.callback
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}