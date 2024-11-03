import 'package:reactive_client/repository/entities/student_entity.dart';

abstract class StudentsState{}

class StudentsInitialState implements StudentsState{}

class StudentsRetrievingState implements StudentsState{}

class StudentsRetrievedState implements StudentsState{
  final List<StudentEntity> students;

  StudentsRetrievedState(this.students);
}

class StudentsFailureState implements StudentsState{}