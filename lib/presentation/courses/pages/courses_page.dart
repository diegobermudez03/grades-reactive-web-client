import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_client/presentation/courses/controllers/courses_bloc.dart';
import 'package:reactive_client/presentation/courses/controllers/courses_states.dart';
import 'package:reactive_client/presentation/courses/widgets/course_tile.dart';

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
        CoursesRetrievedState(courses: final courses)=> CoursesTable(courses: courses),
        CoursesState() => const Center(child: CircularProgressIndicator(),)
      };
    });
  }
}