import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_client/presentation/courses/controllers/courses_bloc.dart';
import 'package:reactive_client/presentation/courses/controllers/courses_states.dart';

class CoursesPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesBloc, CoursesState>(builder: (context, state){
      final provider = BlocProvider.of<CoursesBloc>(context);
      return switch(state){
        
      };
    });
  }
}