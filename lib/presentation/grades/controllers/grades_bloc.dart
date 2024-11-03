import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_client/presentation/grades/controllers/grades_states.dart';
import 'package:reactive_client/repository/entities/grade_entity.dart';
import 'package:reactive_client/repository/repository.dart';

class GradesBloc extends Cubit<GradesState>{

  final Repository repo;

  GradesBloc(
    this.repo
  ):super(GradesInitialState());

  void getGrades(int studentId, int courseId)async{
    await Future.delayed(Duration.zero);
    final response = await repo.getGradesForStudentInCourse(studentId, courseId);

    response.fold(
      (f)=> emit(GradesRetreievingFaliureState()), 
      (grades)async{
        final ponderada = await repo.getPonderadaGrade(courseId, studentId);
        ponderada.fold(
          (f)=>emit(GradesRetreievingFaliureState()), 
          (suc)=>emit(GradesRetrievedState(grades,0,0,false, suc.value1, suc.value2))
        );
      });

  }


  void saveGrades(List<Tuple4<int?, double, double, String>> widgetGrades, int studentId, int courseId) async {
    await Future.delayed(Duration.zero);

    final List<GradeEntity> previousGrades = state is GradesRetrievedState 
        ? (state as GradesRetrievedState).grades 
        : [];

    final List<Future<int>> addedGradeFutures = widgetGrades
        .where((wid) => wid.value1 == null)
        .map((wid) async {
          final response = await repo.addGradeToStudentInCourse(
              courseId, studentId, GradeEntity(null, wid.value3, wid.value2, wid.value4));
          return response.fold((f) => 0, (r) => 1);
        }).toList();

    final int addedGrades = (await Future.wait(addedGradeFutures)).fold(0, (prev, curr) => prev + curr);

    final List<Future<int>> updateFutures = widgetGrades
        .where((wid) => wid.value1 != null)
        .expand((wid) {
          return previousGrades
              .where((g) => g.id == wid.value1)
              .where((g) => (g.value != wid.value2) || (g.percentage != wid.value3) || (g.comments != wid.value4))
              .map((_) async {
                final response = await repo.updateGrade(GradeEntity(wid.value1, wid.value3, wid.value2, wid.value4));
                return response.fold((_) => 0, (_) => 1);
              });
        }).toList();

    final int updatedGrades = (await Future.wait(updateFutures)).fold(0, (prev, curr) => prev + curr);

    final response = await repo.getGradesForStudentInCourse(studentId, courseId);

    response.fold(
      (f) => emit(GradesRetreievingFaliureState()), 
      (grades) async {
        final ponderada = await repo.getPonderadaGrade(courseId, studentId);
        ponderada.fold(
          (f) => emit(GradesRetreievingFaliureState()), 
          (suc) => emit(GradesRetrievedState(grades, addedGrades, updatedGrades, false, suc.value1, suc.value2))
        );
      }
    );
  }


  void deleteGrade(int gradeId) async{
    await Future.delayed(Duration.zero);
    final List<GradeEntity> previousGrades = switch(state){
      GradesRetrievedState(grades: final g) => g,
      GradesState()=>[]
    };

    final response = await repo.deleteGrade(gradeId);
    response.fold(
      (f)=>emit(GradesRetreievingFaliureState()), 
      (s){
        previousGrades.removeWhere((g)=>g.id == gradeId);
        emit(GradesRetrievedState(previousGrades, 0, 0, true, s.value1, s.value2));
      });
  }
  
}