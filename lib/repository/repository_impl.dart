import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:reactive_client/core/failures.dart';
import 'package:reactive_client/repository/entities/course_entity.dart';
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



  List<T> _processListResponse<T>(String json, T Function(Map<String, dynamic>) parser){
    final jsonList = jsonDecode(json) as List<dynamic>;
    return jsonList.map((json)=>
          parser(json)
      ).toList();
  }
  

  
}