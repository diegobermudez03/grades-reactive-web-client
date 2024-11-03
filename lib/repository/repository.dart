import 'package:dartz/dartz.dart';
import 'package:reactive_client/core/failures.dart';
import 'package:reactive_client/repository/entities/course_entity.dart';
import 'package:reactive_client/repository/entities/student_entity.dart';

abstract class Repository{

  Future<Either<Failure, List<CourseEntity>>> getCourses();

  Future<Either<Failure, List<StudentEntity>>> getStudentsFromCourse(int courseId);

  Future<Either<Failure, List<StudentEntity>>> getAllStudents();
}