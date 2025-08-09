import 'package:flutter/material.dart';
import 'package:mobile/models/task.dart';
import 'package:mobile/providers/task_provider.dart';
import 'package:mobile/screens/task/widgets/create_widget.dart';
import 'package:mobile/screens/task/widgets/edit_widget.dart';
import 'package:provider/provider.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  bool _isSelecting = false;
  final Set<String> _selectedTasks = {};

  @override
  void initState() {
    super.initState();
    // Cargar tareas al iniciar el widget
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    context.read<TaskProvider>().getTasks();
  }

  Future<void> _deleteTasksSelected() async {
    // Mostrar el diálogo modal con loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
    await context.read<TaskProvider>().deleteTasksSelected(_selectedTasks);
    _clearSelection();
    // Cerrar el diálogo modal
    if (!mounted) return;
    Navigator.pop(context);
  }

  void _openCreateTaskForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return CreateTaskForm();
      },
    );
  }

  void _openEditTaskForm(Task task) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return EditTaskForm(task: task);
      },
    );
  }

  // FUNCIONES PARA MODO SELECCION

  void _toggleSelection(String id) {
    setState(() {
      if (_selectedTasks.contains(id)) {
        _selectedTasks.remove(id);
        if (_selectedTasks.isEmpty) _isSelecting = false;
      } else {
        _selectedTasks.add(id);
      }
    });
  }

  void _startSelection(String id) {
    setState(() {
      _isSelecting = true;
      _selectedTasks.add(id);
    });
  }

  void _clearSelection() {
    setState(() {
      _isSelecting = false;
      _selectedTasks.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();

    return Scaffold(
      appBar: AppBar(
        title: _isSelecting
            ? Text("${_selectedTasks.length} seleccionadas")
            : const Text('Mis Tareas'),
        centerTitle: true,
        leading: _isSelecting
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: _clearSelection,
              )
            : null,
        actions: [
          if (_isSelecting)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _selectedTasks.isEmpty ? null : _deleteTasksSelected,
            )
          else
            IconButton(
              onPressed: _openCreateTaskForm,
              icon: const Icon(Icons.add),
            ),
        ],
      ),
      body: taskProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                taskProvider.tasks.isEmpty && !_isSelecting
                    ? const Center(child: Text("No hay tareas"))
                    : Expanded(
                        child: ListView.builder(
                          itemCount: taskProvider.tasks.length,
                          itemBuilder: (context, index) {
                            final task = taskProvider.tasks[index];
                            final isSelected = _selectedTasks.contains(task.id);

                            return GestureDetector(
                              onLongPress: () => _startSelection(task.id),
                              onTap: () {
                                if (_isSelecting) {
                                  _toggleSelection(task.id);
                                } else {
                                  // acción normal si no está seleccionando
                                  _openEditTaskForm(task);
                                }
                              },
                              child: Container(
                                color: isSelected
                                    ? Colors.blue.withValues(alpha: 0.2)
                                    : Colors.transparent,
                                child: ListTile(
                                  title: Text(
                                    task.title,
                                    style: TextStyle(
                                      decoration: task.status == "DONE"
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                      color: task.status == "DONE"
                                          ? Colors.grey
                                          : Colors.black,
                                    ),
                                  ),
                                  subtitle: Text(
                                    task.description,
                                    style: TextStyle(
                                      decoration: task.status == "DONE"
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                      color: task.status == "DONE"
                                          ? Colors.grey
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ],
            ),
    );
  }
}
