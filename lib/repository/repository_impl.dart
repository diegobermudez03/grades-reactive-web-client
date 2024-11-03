import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:reactive_client/core/failures.dart';
import 'package:reactive_client/repository/entities/course_entity.dart';
import 'package:reactive_client/repository/entities/grade_entity.dart';
import 'package:reactive_client/repository/entities/student_entity.dart';
import 'package:reactive_client/repository/parsers.dart';
import 'package:reactive_client/repository/repository.dart';

class RepositoryImpl implements Repository{
  final String uri;
  RepositoryImpl(this.uri);

  @override
  Future<Either<Failure, List<CourseEntity>>> getCourses() async{
    final url = Uri.parse('$uri/cursos/all');
    final response = await http.get(url);
    if(response.statusCode == 200){
      return Right(_processListResponse(response.body, jsonToCourseEntity));
    }else{
      return Left(APIFailure(response.body));
    }
  }

  @override
  Future<Either<Failure, List<StudentEntity>>> getStudentsFromCourse(int courseId) async{
    final url = Uri.parse('$uri/estudiantes/byCurso/$courseId');
    final response = await http.get(url);
    if(response.statusCode == 200){
      return Right(_processListResponse(response.body, jsonToStudentEntity));
    }else{
      return Left(APIFailure(response.body));
    }
  }

  @override
  Future<Either<Failure, List<StudentEntity>>> getAllStudents() async{
    final url = Uri.parse('$uri/estudiantes/all');
    final response = await http.get(url);
    if(response.statusCode == 200){
      return Right(_processListResponse(response.body, jsonToStudentEntity));
    }else{
      return Left(APIFailure(response.body));
    }
  }

  @override
  Future<Either<Failure, List<GradeEntity>>> getGradesForStudentInCourse(int studentId, int courseId) async{
    final url = Uri.parse('$uri/notas/$courseId/$studentId');
    final response = await http.get(url);
    if(response.statusCode == 200){
      return Right(_processListResponse(response.body, jsonToGradeEntity));
    }else{
      return Left(APIFailure(response.body));
    }
  }

  @override
  Future<Either<Failure, double>> addGradeToStudentInCourse(int courseId, int studentId, GradeEntity grade) async{
    final url = Uri.parse('$uri/notas/$courseId/$studentId');
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json", 
      },
      body: jsonEncode({
        "cursoId" : courseId,
        "estudianteId": studentId,
        "observacion" : grade.comments,
        "valor": grade.value,
        "porcentaje": grade.percentage
      })
    );
    if(response.statusCode == 200){
      return Right(jsonDecode(response.body)["valor"]);
    }else{
      return Left(APIFailure(response.body));
    }
  }
  
  @override
  Future<Either<Failure, Tuple2<double, double>>> deleteGrade(int id)async {
    final url = Uri.parse('$uri/notas/$id');
    final response = await http.delete(url);
    if(response.statusCode == 200){
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return Right(Tuple2<double, double>(body["valor"], body["porcentaje"]));
    }else{
      return Left(APIFailure(response.body));
    }
  }
  
  @override
  Future<Either<Failure, Tuple2<double, double>>> getPonderadaGrade(int courseId, int studentId) async{
    final url = Uri.parse('$uri/notas/ponderado/$courseId/$studentId');
    final response = await http.get(url);
    if(response.statusCode == 200){
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return Right(Tuple2<double, double>(body["valor"], body["porcentaje"]));
    }else{
      return Left(APIFailure(response.body));
    }
  }
  
  @override
  Future<Either<Failure, double>> updateGrade(GradeEntity grade) async{
    final url = Uri.parse('$uri/notas/${grade.id}');
    final response = await http.patch(
      url,
      headers: {
        "Content-Type": "application/json", 
      },
      body: jsonEncode({
        "id":grade.id,
        "observacion" : grade.comments,
        "valor": grade.value,
        "porcentaje": grade.percentage
      })
    );
    if(response.statusCode == 200){
      return Right(jsonDecode(response.body)["valor"]);
    }else{
      return Left(APIFailure(response.body));
    }
  }

  List<T> _processListResponse<T>(String json, T Function(Map<String, dynamic>) parser){
    final jsonList = jsonDecode(json) as List<dynamic>;
    return jsonList.map((json)=>
          parser(json)
      ).toList();
  }
  
}