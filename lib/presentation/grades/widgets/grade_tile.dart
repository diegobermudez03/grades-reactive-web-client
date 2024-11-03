import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart' as dartz;

class GradeTile extends StatelessWidget{

  final dartz.Tuple4<int?, TextEditingController, TextEditingController, TextEditingController> grade;
  final void Function(int?) removeCallback;

  GradeTile({
    super.key,
    required this.grade,
    required this.removeCallback
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(grade.value1 != null ? 'Nota ${grade.value1}' : 'Nueva nota'),
        TextField(controller: grade.value2,),
        Text('Porcentaje'),
        TextField(controller: grade.value3,),
        Text('observacion'),
        TextField(controller: grade.value4,),
        IconButton(onPressed: ()=> removeCallback(grade.value1), icon: Icon(Icons.delete, color: Colors.red,))
      ],
    );
  }

}