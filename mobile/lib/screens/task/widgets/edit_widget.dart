import 'package:flutter/material.dart';
import 'package:mobile/models/task.dart';
import 'package:mobile/providers/task_provider.dart';
import 'package:provider/provider.dart';

class EditTaskForm extends StatefulWidget {
  final Task task;
  const EditTaskForm({super.key, required this.task});

  @override
  State<EditTaskForm> createState() => _EditTaskFormState();
}

class _EditTaskFormState extends State<EditTaskForm> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  // Funcion que se ejecuta al iniciar el widget
  @override
  void initState() {
    super.initState();
    _titleController.text = widget.task.title;
    _descriptionController.text = widget.task.description;
  }

  // Funcion que ejecuta el updateTask del provider
  void _handleSubmit() {
    final taskProvider = context.read<TaskProvider>();
    taskProvider.updateTask(
      title: _titleController.text,
      description: _descriptionController.text,
      id: widget.task.id,
    );
    Navigator.pop(context);
  }

  void _handleComplete() {
    final taskProvider = context.read<TaskProvider>();
    taskProvider.updateTaskComplete(widget.task.id);
    Navigator.pop(context);
  }

  void _handlePending() {
    final taskProvider = context.read<TaskProvider>();
    taskProvider.updateTaskPending(widget.task.id);
    Navigator.pop(context);
  }

  // Funcion que libera los controladores
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Editar tarea",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              if (widget.task.status != "DONE")
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Text(
                    "Marcar como completada",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => _handleComplete(),
                )
              else
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text(
                    "Marcar como pendiente",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => _handlePending(),
                ),
            ],
          ),
          SizedBox(height: 12),
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: "Título",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: "Descripción",
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _handleSubmit(),
              child: Text("Guardar"),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
