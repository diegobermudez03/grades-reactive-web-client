import 'package:reactive_client/repository/entities/grade_entity.dart';

abstract class GradesState{}

class GradesInitialState implements GradesState{}

class GradesRetreievingState implements GradesState{}

class GradesRetreievingFaliureState implements GradesState{}

class GradesRetrievedState implements GradesState{
  final List<GradeEntity> grades;
  final bool addedGrade;
  final bool removedGrade;

  GradesRetrievedState(this.grades, this.addedGrade, this.removedGrade);
}