import 'package:reactive_client/repository/entities/grade_entity.dart';

abstract class GradesState{}

class GradesInitialState implements GradesState{}

class GradesRetreievingState implements GradesState{}

class GradesRetreievingFaliureState implements GradesState{}

class GradesRetrievedState implements GradesState{
  final List<GradeEntity> grades;
  final int gradesAdded;
  final int gradesUpdated;
  final bool removedGrade;
  final double ponderada;
  final double percentageAccumulated;

  GradesRetrievedState(this.grades, this.gradesAdded,this.gradesUpdated, this.removedGrade, this.ponderada, this.percentageAccumulated);
}