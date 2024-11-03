import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_client/presentation/courses/controllers/courses_states.dart';

class CoursesBloc extends Cubit<CoursesState>{

  

  CoursesBloc():super(CoursesInitialState());
  

  void getCourses()async{

  }
}