import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_client/presentation/grades/controllers/grades_states.dart';
import 'package:reactive_client/repository/repository.dart';

class GradesBloc extends Cubit<GradesState>{

  final Repository repo;

  GradesBloc(
    this.repo
  ):super(GradesInitialState());
  
}