import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_client/presentation/students/controller/students_states.dart';

class StudentsBloc extends Cubit<StudentsState>{

  StudentsBloc():super(StudentsInitialState());

  void GetStudents(int courseId)async{

  }
}