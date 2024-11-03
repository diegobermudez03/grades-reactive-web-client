import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/services.dart';

class GradeTile extends StatelessWidget {
  final dartz.Tuple4<int?, TextEditingController, TextEditingController, TextEditingController> grade;
  final void Function(int?) removeCallback;
  final gradeInputFormatter = FilteringTextInputFormatter.allow(RegExp(r'^\d(\.\d{0,2})?$')); 
  final percentageInputFormatter = FilteringTextInputFormatter.allow(RegExp(r'^\d{0,2}(\.\d{0,2})?$')); 

  GradeTile({
    Key? key,
    required this.grade,
    required this.removeCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Expanded(
              flex: 1,
              child: Text('Nota',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(width: 10),
            _buildInputColumn('Nota', grade.value2, 'Ingrese nota', gradeInputFormatter, context),
            const SizedBox(width: 10),
            _buildInputColumn('Porcentaje', grade.value3, 'Ingrese %', percentageInputFormatter, context),
            const SizedBox(width: 10),
            _buildInputColumn('Observación', grade.value4, 'Ingrese observación', null, context, isPercentage: false),
            IconButton(
              onPressed: () => removeCallback(grade.value1),
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputColumn(
    String label,
    TextEditingController controller,
    String hintText,
    TextInputFormatter? formatter,
    BuildContext context, {
    bool isPercentage = true,
  }) {
    return Expanded(
      flex: isPercentage ? 1 : 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          Material(
            elevation: 1,
            borderRadius: BorderRadius.circular(8),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                hintText: hintText,
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: formatter != null ? [formatter] : [],
            ),
          ),
        ],
      ),
    );
  }
}
