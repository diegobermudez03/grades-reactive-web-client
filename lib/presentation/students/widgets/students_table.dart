import 'package:flutter/material.dart';
import 'package:reactive_client/repository/entities/student_entity.dart';

class StudentsTable extends StatelessWidget {
  final List<StudentEntity> courseStudents;
  final List<StudentEntity> allStudents;
  final void Function(BuildContext, StudentEntity) callback;

  const StudentsTable({
    super.key,
    required this.courseStudents,
    required this.allStudents,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _studentDropdownWithButton(context),
          const SizedBox(height: 20),
          _printHeader(),
          const Divider(thickness: 1),
          ..._printRows(courseStudents, context, (student) => callback(context, student)),
        ],
      ),
    );
  }

  Widget _printHeader() {
    return const Padding(
      padding:  EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:  [
          Text("ID", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("Nombre", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("Apellido", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("Correo", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("Notas", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  List<Widget> _printRows(List<StudentEntity> students,BuildContext context, void Function(StudentEntity) callback) {
    return students.map((student) {
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('${student.id}'),
              Text(student.name),
              Text(student.lastName),
              Text(student.email),
              TextButton(
                onPressed: () => callback(student),
                style: TextButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, foregroundColor: Colors.white,),
                child: const Text("Mostrar"),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  Widget _studentDropdownWithButton(BuildContext context) {
    StudentEntity? selectedStudent;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<StudentEntity>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Seleccionar Estudiante",
                  ),
                  value: selectedStudent,
                  items: allStudents.map((student) {
                    return DropdownMenuItem<StudentEntity>(
                      value: student,
                      child: Text('${student.name} ${student.lastName}'),
                    );
                  }).toList(),
                  onChanged: (StudentEntity? newValue) {
                    setState(() {
                      selectedStudent = newValue;
                    });
                  },
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: selectedStudent == null
                    ? null
                    : () {
                        if (selectedStudent != null) {
                          callback(context, selectedStudent!);
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Agregar notas"),
              ),
            ],
          ),
        );
      },
    );
  }
}
