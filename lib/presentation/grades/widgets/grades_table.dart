import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_client/presentation/grades/controllers/grades_bloc.dart';
import 'package:reactive_client/presentation/grades/widgets/grade_tile.dart';
import 'package:reactive_client/repository/entities/grade_entity.dart';
import 'package:reactive_client/repository/entities/student_entity.dart';

class GradesTable extends StatefulWidget{

  final StudentEntity student;
  final List<GradeEntity> grades;

  GradesTable({
    super.key, 
    required this.student, 
    required this.grades
  });

  @override
  State<GradesTable> createState() => _GradesTableState(grades);
}

class _GradesTableState extends State<GradesTable> {

  final List<dartz.Tuple4<int?, TextEditingController, TextEditingController, TextEditingController>> gradesForWidget;

  _GradesTableState(List<GradeEntity> grades):
    gradesForWidget = grades.map(
      (entity)=> dartz.Tuple4<int, TextEditingController, TextEditingController, TextEditingController>(
        entity.id!, 
        TextEditingController(text: entity.value.toString()), 
        TextEditingController(text: entity.percentage.toString()),
        TextEditingController(text: entity.comments), 
      )).toList();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text('${widget.student.name} ${widget.student.lastName}'),
          ..._printGrades(context),
          IconButton(onPressed: _addGradeField, icon: Icon(Icons.add)),
          TextButton(onPressed:()=>_saveGrades(context), child: Text("Guardar"))
        ],
      ),
    );
  }

  List<Widget> _printGrades(BuildContext context){
    return gradesForWidget.map((grade)=>GradeTile(grade: grade, removeCallback: (id)=>deleteGrade(context, id, grade))).toList();
  }

  void _addGradeField(){
    setState(() {
      gradesForWidget.add(
        dartz.Tuple4(null, TextEditingController(text: '0'), TextEditingController(text: '0'), TextEditingController(text: ''))
      );
    });
  }

  void _saveGrades(BuildContext context){
    final provider = BlocProvider.of<GradesBloc>(context);
    provider.saveGrades(
      gradesForWidget.map((widget)=>dartz.Tuple4(
        widget.value1,
        double.parse(widget.value2.text),
        double.parse(widget.value3.text),
        widget.value4.text
      )).toList()
    );
  }

  void deleteGrade(BuildContext context, int? gradeId, dartz.Tuple4<int?, TextEditingController, TextEditingController,TextEditingController> widget){
    if(gradeId == null){
      setState(() {
        gradesForWidget.removeWhere((w)=> identical(w, widget));
      });
    }else{
      final provider = BlocProvider.of<GradesBloc>(context);
      provider.deleteGrade(gradeId);
    }
  }
}