import 'package:flutter/material.dart';
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
    return Column(
      children: [
        _printHeader(),
        ..._printRows(students, (student)=>callback(context, student)),
      ],
    );
  }

  Widget _printHeader(){
    return const Row(
      children: [
        Text("ID"),
        Text("Nombre"),
        Text("Apellido"),
        Text("Correo"),
        Text("Notas")
      ],
    );
  }

  List<Widget> _printRows(List<StudentEntity> students, void Function(StudentEntity) callback){
    return students.map((student)=>
        Row(children: [
          Text('${student.id}'),
          Text(student.name),
          Text(student.lastName),
          Text(student.email),
          TextButton(onPressed:()=>callback(student), child: Text("Mostrar"))
        ],)
      ).toList();
  }
}