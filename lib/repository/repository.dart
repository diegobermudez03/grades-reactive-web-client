import 'package:dartz/dartz.dart';
import 'package:reactive_client/core/failures.dart';
import 'package:reactive_client/repository/entities/course_entity.dart';

abstract class Repository{

  Future<Either<Failure, List<CourseEntity>>> getCourses();
}