import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_client/presentation/grades/controllers/grades_bloc.dart';
import 'package:reactive_client/presentation/grades/widgets/grade_tile.dart';
import 'package:reactive_client/repository/entities/grade_entity.dart';
import 'package:reactive_client/repository/entities/student_entity.dart';

class GradesTable extends StatefulWidget {
  final StudentEntity student;
  final int courseId;
  final List<GradeEntity> grades;
  final double ponderada;
  final double percentage;

  GradesTable({
    Key? key,
    required this.student,
    required this.courseId,
    required this.grades,
    required this.ponderada,
    required this.percentage,
  }) : super(key: key);

  @override
  State<GradesTable> createState() => _GradesTableState(grades);
}

class _GradesTableState extends State<GradesTable> {
  List<dartz.Tuple4<int?, TextEditingController, TextEditingController, TextEditingController>> gradesForWidget;

  _GradesTableState(List<GradeEntity> grades)
      : gradesForWidget = grades.map((entity) {
          return dartz.Tuple4<int?, TextEditingController, TextEditingController, TextEditingController>(
            entity.id,
            TextEditingController(text: entity.value.toString()),
            TextEditingController(text: entity.percentage.toString()),
            TextEditingController(text: entity.comments),
          );
        }).toList();

  @override
  void didUpdateWidget(GradesTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    gradesForWidget = widget.grades.map((entity) {
      return dartz.Tuple4<int?, TextEditingController, TextEditingController, TextEditingController>(
        entity.id,
        TextEditingController(text: entity.value.toString()),
        TextEditingController(text: entity.percentage.toString()),
        TextEditingController(text: entity.comments),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.student.name} ${widget.student.lastName}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Nota ponderada actual: ${widget.ponderada.toStringAsFixed(2)}', style: TextStyle(fontSize: 20)),
            Text('Porcentaje restante: %${widget.percentage}', style: TextStyle(fontSize: 20)),
            const Divider(thickness: 1, height: 24),
            ..._printGrades(context),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: _addGradeField,
                  icon: const Icon(Icons.add),
                  label: const Text("Agregar Nota"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _saveGrades(context),
                  child: const Text("Guardar"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _printGrades(BuildContext context) {
    return gradesForWidget
        .map((grade) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: GradeTile(
                grade: grade,
                removeCallback: (id) => deleteGrade(context, id, grade),
              ),
            ))
        .toList();
  }

  void _addGradeField() {
    setState(() {
      gradesForWidget.add(
        dartz.Tuple4<int?, TextEditingController, TextEditingController, TextEditingController>(
          null,
          TextEditingController(),
          TextEditingController(),
          TextEditingController(),
        ),
      );
    });
  }

  void _saveGrades(BuildContext context) {
    final allFieldsFilled = gradesForWidget.every((w) =>
        w.value2.text.isNotEmpty && w.value3.text.isNotEmpty && w.value4.text.isNotEmpty);

    if (!allFieldsFilled) {
      _showDialog(context, "Complete todos los campos para guardar.");
      return;
    }

    final totalPercentage = gradesForWidget.fold<double>(
        0, (sum, wid) => sum + double.parse(wid.value3.text));

    if (totalPercentage > 100) {
      _showDialog(context, "El porcentaje total no puede superar el 100%.");
      return;
    }

    final provider = BlocProvider.of<GradesBloc>(context);
    provider.saveGrades(
      gradesForWidget.map((widget) {
        return dartz.Tuple4(
          widget.value1,
          double.parse(widget.value2.text),
          double.parse(widget.value3.text),
          widget.value4.text,
        );
      }).toList(),
      widget.student.id,
      widget.courseId,
    );
  }

  void deleteGrade(BuildContext context, int? gradeId, dartz.Tuple4<int?, TextEditingController, TextEditingController, TextEditingController> widget) {
    if (gradeId == null) {
      setState(() {
        gradesForWidget.removeWhere((w) => identical(w, widget));
      });
    } else {
      final provider = BlocProvider.of<GradesBloc>(context);
      provider.deleteGrade(gradeId);
    }
  }

  void _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (subContext) {
        return AlertDialog(
          content: Text(message),
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
