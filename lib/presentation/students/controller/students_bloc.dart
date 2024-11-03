import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_client/presentation/students/controller/students_states.dart';
import 'package:reactive_client/repository/repository.dart';

class StudentsBloc extends Cubit<StudentsState>{

  final Repository repo;

  StudentsBloc(
    this.repo
  ):super(StudentsInitialState());

  void GetStudents(int courseId)async{

  }
}