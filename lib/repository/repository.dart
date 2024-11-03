import 'package:dartz/dartz.dart';
import 'package:reactive_client/core/failures.dart';
import 'package:reactive_client/repository/entities/course_entity.dart';
import 'package:reactive_client/repository/entities/grade_entity.dart';
import 'package:reactive_client/repository/entities/student_entity.dart';

abstract class Repository{

  Future<Either<Failure, List<CourseEntity>>> getCourses();

  Future<Either<Failure, List<StudentEntity>>> getStudentsFromCourse(int courseId);

  Future<Either<Failure, List<StudentEntity>>> getAllStudents();

  Future<Either<Failure, List<GradeEntity>>> getGradesForStudentInCourse(int studentId, int courseId);

  Future<Either<Failure, double>> addGradeToStudentInCourse(int courseId, int studentId, GradeEntity grade);

  Future<Either<Failure, Tuple2<double, double>>> getPonderadaGrade(int courseId, int studentId);

  Future<Either<Failure, double>>  updateGrade(GradeEntity grade);

  Future<Either<Failure, Tuple2<double, double>>> deleteGrade(int id);
}