import '../model/todo_model.dart';

abstract class TodoEvents {}

class LoadTodoEvents extends TodoEvents {}

class AddNewTodoEvent extends TodoEvents {
  final TodoModel todo;
  AddNewTodoEvent(this.todo);
}

class DeleteTodoEvent extends TodoEvents {
  final int id;
  DeleteTodoEvent(this.id);
}

class UpdateTodoEvent extends TodoEvents {
  final int id;
  final TodoModel todo;
  UpdateTodoEvent(this.id, this.todo);
}
