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
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<GradesBloc, GradesState>(
        listener: (context, state) {
          if(state is GradesRetrievedState){
            if(state.removedGrade){
              showDialog(
                context: context, builder: (subcontext){
                  return AlertDialog(content: Text("Nota eliminada exitosamente"),);
                });
            }
            else if(state.gradesAdded >0 || state.gradesUpdated > 0){
              showDialog(
                context: context, builder: (subcontext){
                  return AlertDialog(content: 
                  Column(
                    children: [
                      Text(state.gradesAdded > 0 ? '${state.gradesAdded} notas agregadas ':''),
                      Text(state.gradesUpdated > 0 ? '${state.gradesUpdated} notas actualizadas ':''),
                    ],
                  ),);
                });
            }
          }
        },
        child: BlocBuilder<GradesBloc, GradesState>(builder: (context, state){
            final provider = BlocProvider.of<GradesBloc>(context);
            if(state is GradesInitialState){
              provider.getGrades(student.id, courseId);
            }
            
            return switch(state){
              GradesRetrievedState(grades: final grades, ponderada: final pond, percentageAccumulated: final perc)=> GradesTable(student: student, grades: grades, courseId: courseId,ponderada: pond, percentage: 100-perc ,),
              GradesRetreievingFaliureState()=> const Center(child: Text("Hubo un error obteniendo las notas"),),
              GradesState() => const Center(child: CircularProgressIndicator(),)
            };
          }),
      ),
    );
  }
}