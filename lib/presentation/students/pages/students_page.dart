import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:reactive_client/presentation/grades/controllers/grades_bloc.dart';
import 'package:reactive_client/presentation/grades/pages/grades_page.dart';
import 'package:reactive_client/presentation/students/controller/students_bloc.dart';
import 'package:reactive_client/presentation/students/controller/students_states.dart';
import 'package:reactive_client/presentation/students/widgets/students_table.dart';
import 'package:reactive_client/repository/entities/course_entity.dart';
import 'package:reactive_client/repository/entities/student_entity.dart';

class StudentsPage extends StatelessWidget {
  final CourseEntity course;

  StudentsPage({
    Key? key,
    required this.course,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(course.materia.name),
      ),
      body: BlocBuilder<StudentsBloc, StudentsState>(builder: (context, state) {
        final provider = BlocProvider.of<StudentsBloc>(context);
        if (state is StudentsInitialState) {
          provider.getStudents(course.id);
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Código del Curso: ${course.code}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: switch (state) {
                StudentsFailureState() => const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, color: Colors.red, size: 60),
                      SizedBox(height: 10),
                      Text(
                        "Hubo un error al obtener los estudiantes",
                        style: TextStyle(fontSize: 16, color: Colors.redAccent),
                      ),
                    ],
                  ),
                ),
                StudentsRetrievedState(courseStudents: final cStudents, allStudents: final all) => StudentsTable(
                  courseStudents: cStudents,
                  allStudents: all,
                  callback: handleStudentGrades(course.id),
                ),
                StudentsState() => const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text(
                        "Cargando estudiantes...",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              },
            ),
          ],
        );
      }),
    );
  }

  void Function(BuildContext, StudentEntity) handleStudentGrades(int courseId) {
    return (context, student) {
      Navigator.pop(context);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (subContext) => BlocProvider(
            create: (c) => GetIt.instance.get<GradesBloc>(),
            child: GradesPage(student: student, courseId: courseId),
          ),
        ),
      );
    };
  }
}
