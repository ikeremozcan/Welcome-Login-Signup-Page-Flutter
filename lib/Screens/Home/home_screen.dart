import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/services/not_todos_provider.dart';
import 'package:provider/provider.dart';

import '../../services/firebase_auth_methods.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                NotTodosProvider(context.read<FirebaseAuthMethods>())),
      ],
      child: const UserDetail(),
    );
  }
}

class UserDetail extends StatefulWidget {
  const UserDetail({super.key});

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  Future<void> addNotTodo() async {
    var db = FirebaseFirestore.instance;
    var user = context.read<FirebaseAuthMethods>().user;

    final notTodo = <String, dynamic>{
      "email": user?.email,
      "title": "testkrm",
      "description": "descriptionkkk"
    };
    final result = await db.collection("not_todos").add(notTodo);
    if (result.id.isNotEmpty) {
      context.read<NotTodosProvider>().getNotTodos();
    }
  }

  void logout() {
    context.read<FirebaseAuthMethods>().signOut(context);
  }

  @override
  void initState() {
    context.read<NotTodosProvider>().getNotTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = context.read<FirebaseAuthMethods>().user;
    return Material(
      child: SafeArea(
        child: Column(
          children: [
            Text(user?.email ?? ""),
            IconButton(
              onPressed: addNotTodo,
              icon: const Icon(Icons.add),
            ),
            Expanded(
              child: Consumer<NotTodosProvider>(
                builder: (context, notTodosProvider, child) {
                  return notTodosProvider.notTodos.isEmpty
                      ? Container()
                      : ListView.builder(
                          itemBuilder: (context, index) => ListTile(
                            title: Text(notTodosProvider.notTodos[index].title),
                          ),
                          itemCount: notTodosProvider.notTodos.length,
                        );
                },
              ),
            ),
            TextButton(
              onPressed: logout,
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
