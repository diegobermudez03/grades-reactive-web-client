import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/services.dart';

class GradeTile extends StatelessWidget {
  final dartz.Tuple4<int?, TextEditingController, TextEditingController, TextEditingController> grade;
  final void Function(int?) removeCallback;
  final gradeInputFormatter = FilteringTextInputFormatter.allow(RegExp(r'^\d(\.\d{0,2})?$')); 
  final percentageInputFormatter = FilteringTextInputFormatter.allow(RegExp(r'^\d{0,2}(\.\d{0,2})?$')); 

  GradeTile({
    super.key,
    required this.grade,
    required this.removeCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                grade.value1 != null ? 'Nota ${grade.value1}' : 'Nueva nota',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nota'),
                  Material(
                    child: TextField(
                      controller: grade.value2,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Ingrese nota',
                      ),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [gradeInputFormatter],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Porcentaje'),
                  Material(
                    child: TextField(
                      controller: grade.value3,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Ingrese %',
                      ),
                       keyboardType: TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [percentageInputFormatter],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Observación'),
                  Material(
                    child: TextField(
                      controller: grade.value4,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Ingrese observación',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => removeCallback(grade.value1),
              icon: Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
