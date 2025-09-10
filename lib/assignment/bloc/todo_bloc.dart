import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:webconcept/assignment/bloc/todo_events.dart';
import 'package:webconcept/assignment/bloc/todo_states.dart';
import 'package:webconcept/assignment/model/todo_model.dart';

class TodoBloc extends Bloc<TodoEvents, TodoState> {
  final Box<TodoModel> todoBox = Hive.box<TodoModel>('todoBox');

  TodoBloc() : super(LoadingTodoState()) {
    on<LoadTodoEvents>((event, emit) {
      emit(LoadedTodoState(todoBox.values.toList()));
    });

    on<AddNewTodoEvent>((event, emit) async {
      await todoBox.add(event.todo);
      emit(LoadedTodoState(todoBox.values.toList()));
    });

    on<DeleteTodoEvent>((event, emit) async {
      await todoBox.deleteAt(event.id);
      emit(LoadedTodoState(todoBox.values.toList()));
    });

    on<UpdateTodoEvent>((event, emit) async {
      await todoBox.putAt(event.id, event.todo);
      emit(LoadedTodoState(todoBox.values.toList()));
    });
  }
}
