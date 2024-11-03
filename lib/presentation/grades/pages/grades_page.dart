import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_client/presentation/grades/controllers/grades_bloc.dart';
import 'package:reactive_client/presentation/grades/controllers/grades_states.dart';
import 'package:reactive_client/presentation/grades/widgets/grades_table.dart';
import 'package:reactive_client/repository/entities/student_entity.dart';

class GradesPage extends StatelessWidget {
  final StudentEntity student;
  final int courseId;

  GradesPage({
    Key? key,
    required this.student,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('${student.name} ${student.lastName} - Notas'),
      ),
      body: BlocListener<GradesBloc, GradesState>(
        listener: (context, state) {
          if (state is GradesRetrievedState) {
            if (state.removedGrade) {
              _showDialog(context, "Nota eliminada exitosamente");
            } else if (state.gradesAdded > 0 || state.gradesUpdated > 0) {
              _showDialog(
                context,
                null,
                [
                  if (state.gradesAdded > 0) Text('${state.gradesAdded} notas agregadas'),
                  if (state.gradesUpdated > 0) Text('${state.gradesUpdated} notas actualizadas'),
                ],
              );
            }
          }
        },
        child: BlocBuilder<GradesBloc, GradesState>(
          builder: (context, state) {
            final provider = BlocProvider.of<GradesBloc>(context);
            if (state is GradesInitialState) {
              provider.getGrades(student.id, courseId);
            }

            return switch (state) {
              GradesRetrievedState(grades: final grades, ponderada: final pond, percentageAccumulated: final perc) =>
                  GradesTable(
                    student: student,
                    grades: grades,
                    courseId: courseId,
                    ponderada: pond,
                    percentage: 100 - perc,
                  ),
              GradesRetreievingFaliureState() => const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, color: Colors.red, size: 60),
                    SizedBox(height: 10),
                    Text(
                      "Hubo un error obteniendo las notas",
                      style: TextStyle(fontSize: 16, color: Colors.redAccent),
                    ),
                  ],
                ),
              ),
              GradesState() => const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text(
                      "Cargando notas...",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            };
          },
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, String? message, [List<Widget>? additionalContent]) {
    showDialog(
      context: context,
      builder: (subContext) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (message != null) Text(message, style: const TextStyle(fontSize: 16)),
              if (additionalContent != null) ...additionalContent,
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(subContext).pop(),
              child: const Text("Cerrar"),
            ),
          ],
        );
      },
    );
  }
}
