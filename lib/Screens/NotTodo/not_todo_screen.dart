import 'package:flutter/material.dart';

class NotTodoScreen extends StatefulWidget {
  const NotTodoScreen({super.key});

  @override
  State<NotTodoScreen> createState() => _NotTodoScreenState();
}

class _NotTodoScreenState extends State<NotTodoScreen> {
  final notTodoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        children: [],
      ),
    );
  }
}
