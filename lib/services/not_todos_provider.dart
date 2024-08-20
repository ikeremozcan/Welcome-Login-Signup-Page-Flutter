import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/not_todo.dart';
import 'firebase_auth_methods.dart';

class NotTodosProvider extends ChangeNotifier {
  final FirebaseAuthMethods _auth;
  final _db = FirebaseFirestore.instance;

  NotTodosProvider(this._auth);

  List<NotTodo> _notTodos = [];
  List<NotTodo> get notTodos => _notTodos;

  Future getNotTodos() async {
    final result = await _db
        .collection("not_todos")
        .where('email', isEqualTo: _auth.user?.email)
        .get();
    _notTodos = result.docs
        .map((t) => NotTodo(
            t.data()["email"], t.data()["title"], t.data()["description"]))
        .toList();
    notifyListeners();
  }
}
