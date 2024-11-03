

import 'package:get_it/get_it.dart';
import 'package:reactive_client/presentation/courses/controllers/courses_bloc.dart';

final depIn = GetIt.instance;


void initializeDependencies(){



  //bloc
  depIn.registerFactory<CoursesBloc>(()=> CoursesBloc());
}