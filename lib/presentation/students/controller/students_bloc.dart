import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_client/core/failures.dart';
import 'package:reactive_client/presentation/students/controller/students_states.dart';
import 'package:reactive_client/repository/entities/student_entity.dart';
import 'package:reactive_client/repository/repository.dart';

class StudentsBloc extends Cubit<StudentsState>{

  final Repository repo;

  StudentsBloc(
    this.repo
  ):super(StudentsInitialState());

  void getStudents(int courseId)async{
    await Future.delayed(Duration.zero);
    emit(StudentsRetrievingState());

    final coursStudentsResponse = await repo.getStudentsFromCourse(courseId);
    final allStudentsResponse = await repo.getAllStudents();

    Tuple2<Failure?, List<StudentEntity>?> courseStudents = coursStudentsResponse.fold(
      (f)=> Tuple2(APIFailure('error con estudiantes del curso'), null), 
      (students)=> Tuple2(null, students)
    );

    if(courseStudents.value1 != null){
      emit(StudentsFailureState());
    }else{
      allStudentsResponse.fold(
        (f)=> emit(StudentsFailureState()), 
        (students)=> emit(StudentsRetrievedState(courseStudents.value2!, students))
      );
    }
  
  }
}