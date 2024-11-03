import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_client/presentation/courses/controllers/courses_states.dart';
import 'package:reactive_client/repository/repository.dart';

class CoursesBloc extends Cubit<CoursesState>{

  final Repository repo;

  CoursesBloc(
    this.repo
  ):super(CoursesInitialState());
  

  void getCourses()async{
    await Future.delayed(Duration.zero);
    emit(CoursesRetrievingState());
    final response = await repo.getCourses();

    response.fold(
      (f)=> emit(CoursesFailureState()), 
      (courses)=> emit(CoursesRetrievedState(courses))
    );
  }
}