import 'package:built_redux_sample/models/models.dart';
import 'package:built_redux_sample/actions/actions.dart';
import 'package:built_redux_sample/presentation/details_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';

class TodoDetails extends StoreConnector<AppState, AppActions, Todo> {
  final String id;

  TodoDetails({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context, Todo todo, AppActions actions) {
    return new DetailsScreen(
      todo: todo,
      onDelete: () => actions.deleteTodoAction(todo.id),
      toggleCompleted: (isComplete) {
        actions.updateTodoAction(new UpdateTodoActionPayload(
          id,
          todo.rebuild((b) => b..complete = isComplete),
        ));
      },
    );
  }

  @override
  Todo connect(AppState state) {
    return state.todos.firstWhere(
      (todo) => todo.id == id,
      orElse: () => new Todo("Nothing Here"),
    );
  }
}
