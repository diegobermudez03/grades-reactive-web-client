import 'package:flutter/material.dart';
import 'package:reactive_client/repository/entities/course_entity.dart';

class CoursesTable extends StatelessWidget {
  final List<CourseEntity> courses;
  final void Function(BuildContext, CourseEntity) callback;

  const CoursesTable({
    super.key,
    required this.courses,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _getHeader(),
          const SizedBox(height: 10),
          ..._buildCourseCards(courses, context),
        ],
      ),
    );
  }

  Widget _getHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:  [
          Text("Materia", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("Profesor", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("Codigo", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("Acciones", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  List<Widget> _buildCourseCards(List<CourseEntity> courses, BuildContext context) {
    return courses.map((entity) {
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInfoColumn("Materia", entity.materia.name),
              _buildInfoColumn("Profesor", '${entity.teacher.name} ${entity.teacher.lastName}'),
              _buildInfoColumn("Codigo", entity.code),
              IconButton(
                icon: Icon(Icons.visibility, color: Theme.of(context).primaryColor),
                onPressed: () => callback(context, entity),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  Widget _buildInfoColumn(String label, String info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(
          info,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
