import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webconcept/assignment/bloc/todo_bloc.dart';
import 'package:webconcept/assignment/bloc/todo_states.dart';

import 'bloc/todo_events.dart';
import 'model/todo_model.dart';

class TodoHomeScreen extends StatefulWidget {
  const TodoHomeScreen({super.key});

  @override
  State<TodoHomeScreen> createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TodoBloc>().add(LoadTodoEvents());
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is LoadingTodoState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedTodoState) {
            if (state.todos.isEmpty) {
              return const Center(child: Text("No tasks found"));
            }
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 12,
                  ),
                  child: ListTile(
                    title: Text(
                      todo.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            final controller = TextEditingController(
                              text: todo.title,
                            );

                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text("Edit Todo"),
                                content: TextField(
                                  controller: controller,
                                  decoration: const InputDecoration(
                                    hintText: "Enter updated task",
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Cancel"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      final updatedTodo = TodoModel(
                                        title: controller.text,
                                      );

                                      context.read<TodoBloc>().add(
                                        UpdateTodoEvent(index, updatedTodo),
                                      );
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Update"),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),

                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            context.read<TodoBloc>().add(
                              DeleteTodoEvent(index),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is ErrorTodoState) {
            return Center(child: Text(state.msg));
          }
          return const Center(child: Text("Something went wrong"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text("Add New Task"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "Enter task title",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final text = controller.text.trim();
              if (text.isNotEmpty) {
                dialogContext.read<TodoBloc>().add(
                  AddNewTodoEvent(TodoModel(title: text)),
                );
                Navigator.pop(context);
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}
