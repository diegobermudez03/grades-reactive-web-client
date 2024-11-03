import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:reactive_client/presentation/grades/controllers/grades_bloc.dart';
import 'package:reactive_client/presentation/grades/pages/grades_page.dart';
import 'package:reactive_client/presentation/students/controller/students_bloc.dart';
import 'package:reactive_client/presentation/students/controller/students_states.dart';
import 'package:reactive_client/presentation/students/widgets/students_table.dart';
import 'package:reactive_client/repository/entities/course_entity.dart';
import 'package:reactive_client/repository/entities/student_entity.dart';

class StudentsPage extends StatelessWidget{

  final CourseEntity course;

  StudentsPage({
    super.key,
    required this.course
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentsBloc, StudentsState>(builder: (context, state) {
      final provider = BlocProvider.of<StudentsBloc>(context);
      if(state is StudentsInitialState){
        provider.getStudents(course.id);
      }
      return Column(
        children: [
          Text(course.materia.name),
          Text(course.code),
          switch(state){
            StudentsFailureState()=> const Center(child: Text("Hubo un error obteniendo los estudiantes"),),
            StudentsRetrievedState(students: final students)=> StudentsTable(students: students, callback: handleStudentGrades(course.id),),
            StudentsState()=> const Center(child: CircularProgressIndicator(),)
          }
        ],
      );
    },);
  }

  void Function(BuildContext, StudentEntity) handleStudentGrades(int courseId){
    return (context, student){
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (subContext)=> BlocProvider(
            create: (c)=> GetIt.instance.get<GradesBloc>(),
            child: GradesPage(student: student, courseId: courseId),
          )
        )
      );
    };
  }
}