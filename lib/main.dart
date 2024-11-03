import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:reactive_client/dependency_injection.dart';
import 'package:reactive_client/presentation/courses/controllers/courses_bloc.dart';
import 'package:reactive_client/presentation/courses/pages/courses_page.dart';

void main() {
  initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      home: BlocProvider<CoursesBloc>(
        create: (context) => GetIt.instance.get<CoursesBloc>(),
        child: CoursesPage(),
      ),
    );
  }
}
