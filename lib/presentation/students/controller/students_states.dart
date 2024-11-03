import 'package:reactive_client/repository/entities/student_entity.dart';

abstract class StudentsState{}

class StudentsInitialState implements StudentsState{}

class StudentsRetrievingState implements StudentsState{}

class StudentsRetrievedState implements StudentsState{
  final List<StudentEntity> courseStudents;
  final List<StudentEntity> allStudents;

  StudentsRetrievedState(this.courseStudents, this.allStudents);
}

class StudentsFailureState implements StudentsState{}