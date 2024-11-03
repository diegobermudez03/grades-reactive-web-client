import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_client/presentation/grades/controllers/grades_states.dart';
import 'package:reactive_client/repository/repository.dart';

class GradesBloc extends Cubit<GradesState>{

  final Repository repo;

  GradesBloc(
    this.repo
  ):super(GradesInitialState());

  void getGrades(int studentId, int courseId)async{
    await Future.delayed(Duration.zero);

  }


  void saveGrades(List<Tuple4<int?, double, double, String>> widgetGrades) async{
    await Future.delayed(Duration.zero);
  }

  void deleteGrade(int gradeId) async{
    await Future.delayed(Duration.zero);
  }

  void updateGrade(Tuple4<int?, double, double, String> grade){
    
  }
  
}