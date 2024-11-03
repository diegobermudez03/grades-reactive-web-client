import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_client/presentation/grades/controllers/grades_bloc.dart';
import 'package:reactive_client/presentation/grades/controllers/grades_states.dart';
import 'package:reactive_client/presentation/grades/widgets/grades_table.dart';
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
    return BlocListener<GradesBloc, GradesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: BlocBuilder<GradesBloc, GradesState>(builder: (context, state){
          final provider = BlocProvider.of<GradesBloc>(context);
          if(state is GradesInitialState){
            provider.getGrades(student.id, courseId);
          }
          return switch(state){
            GradesRetrievedState(grades: final grades)=> GradesTable(student: student, grades: grades),
            GradesRetreievingFaliureState()=> const Center(child: Text("Hubo un error obteniendo las notas"),),
            GradesState() => const Center(child: CircularProgressIndicator(),)
          };
        }),
    );
  }
}