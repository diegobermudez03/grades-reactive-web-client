

import 'package:get_it/get_it.dart';
import 'package:reactive_client/presentation/courses/controllers/courses_bloc.dart';
import 'package:reactive_client/repository/repository.dart';
import 'package:reactive_client/repository/repository_impl.dart';

final depIn = GetIt.instance;

final url = 'http://localhost:8081';

void initializeDependencies(){
  //repository
  depIn.registerLazySingleton<Repository>(()=> RepositoryImpl(url));


  //bloc
  depIn.registerFactory<CoursesBloc>(()=> CoursesBloc());
}