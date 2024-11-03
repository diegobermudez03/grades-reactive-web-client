import 'package:reactive_client/repository/entities/course_entity.dart';

abstract class CoursesState{}

class CoursesInitialState implements CoursesState{}

class CoursesRetrievingState implements CoursesState{}

class CoursesFailureState implements CoursesState{}

class CoursesRetrievedState implements CoursesState{
  final List<CourseEntity> courses;

  CoursesRetrievedState(this.courses);
}