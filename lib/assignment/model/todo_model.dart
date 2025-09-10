import 'package:hive/hive.dart';
part 'todo_model.g.dart';


@HiveType(typeId: 0)
class TodoModel {
  @HiveField(0)
  final String title;
  TodoModel({required this.title});
}

