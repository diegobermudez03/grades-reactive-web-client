import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:reactive_client/presentation/courses/controllers/courses_bloc.dart';
import 'package:reactive_client/presentation/courses/controllers/courses_states.dart';
import 'package:reactive_client/presentation/courses/widgets/course_table.dart';
import 'package:reactive_client/presentation/students/controller/students_bloc.dart';
import 'package:reactive_client/presentation/students/pages/students_page.dart';
import 'package:reactive_client/repository/entities/course_entity.dart';

class CoursesPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesBloc, CoursesState>(builder: (context, state){
      final provider = BlocProvider.of<CoursesBloc>(context);
      if(state is CoursesInitialState){
        provider.getCourses();
      }
      return switch(state){
        CoursesFailureState()=> const Center(child: Text("Hubo un error obteniendo los cursos"),),
        CoursesRetrievedState(courses: final courses)=> CoursesTable(courses: courses, callback: handleSelectStudents,),
        CoursesState() => const Center(child: CircularProgressIndicator(),)
      };
    });
  }

  void handleSelectStudents(BuildContext context, CourseEntity course){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context)=> BlocProvider(
        create: (subContext) => GetIt.instance.get<StudentsBloc>(),
        child: StudentsPage(course: course),
      ))
    );
  }
}