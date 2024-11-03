import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:reactive_client/core/failures.dart';
import 'package:reactive_client/repository/entities/course_entity.dart';
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
      final jsonList = jsonDecode(response.body) as List<dynamic>;
      return Right(jsonList.map((json)=>
          jsonToCourseEntity(json)
      ).toList());
    }else{
      return Left(APIFailure(response.body));
    }
  }
}