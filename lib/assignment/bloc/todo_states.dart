import '../model/todo_model.dart';

abstract class TodoState {}

class LoadingTodoState extends TodoState {}

class LoadedTodoState extends TodoState {
  final List<TodoModel> todos;
  LoadedTodoState(this.todos);
}

class ErrorTodoState extends TodoState {
  final String msg;
  ErrorTodoState(this.msg);
}
