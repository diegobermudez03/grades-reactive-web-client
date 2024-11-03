import 'package:flutter/material.dart';
import 'package:reactive_client/repository/entities/student_entity.dart';

class StudentsTable extends StatelessWidget {
  final List<StudentEntity> courseStudents;
  final List<StudentEntity> allStudents;
  final void Function(BuildContext, StudentEntity) callback;

  StudentsTable({
    super.key,
    required this.courseStudents,
    required this.allStudents,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _studentDropdownWithButton(context),
        _printHeader(),
        ..._printRows(courseStudents, (student) => callback(context, student)),
      ],
    );
  }

  Widget _printHeader() {
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

  List<Widget> _printRows(List<StudentEntity> students, void Function(StudentEntity) callback) {
    return students
        .map(
          (student) => Row(
            children: [
              Text('${student.id}'),
              Text(student.name),
              Text(student.lastName),
              Text(student.email),
              TextButton(
                onPressed: () => callback(student),
                child: Text("Mostrar"),
              ),
            ],
          ),
        )
        .toList();
  }

  Widget _studentDropdownWithButton(BuildContext context) {
    StudentEntity? selectedStudent;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Row(
          children: [
            Material(
              child: DropdownButton<StudentEntity>(
                hint: const Text("Seleccionar Estudiante"),
                value: selectedStudent,
                items: allStudents
                    .map(
                      (student) => DropdownMenuItem<StudentEntity>(
                        value: student,
                        child: Text('${student.name} ${student.lastName}'),
                      ),
                    )
                    .toList(),
                onChanged: (StudentEntity? newValue) {
                  setState(() {
                    selectedStudent = newValue;
                  });
                },
              ),
            ),
            SizedBox(width: 10),
            TextButton(
              onPressed: selectedStudent == null
                  ? null
                  : () {
                      if (selectedStudent != null) {
                        callback(context, selectedStudent!);
                      }
                    },
              child: const Text("Agregar notas"),
            ),
          ],
        );
      },
    );
  }

}
