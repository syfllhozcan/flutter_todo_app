// ignore_for_file: sort_child_properties_last, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:todo_app/components/todo_item.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/constants/images.dart';
import 'package:todo_app/constants/strings.dart';
import 'package:todo_app/model/todo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = Todo.listItemFunc();
  List<Todo> _foundTodo = [];

  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundTodo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(children: [
              searchBox(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: ListView(
                    children: [
                      allTodoString(),
                      //listTodos yerine __foundTodo koyduk
                      for (Todo item in _foundTodo)
                        TodoItem(
                          todo: item,
                          onTodoChenged: _handleTodoChange,
                          onDeleteItem: _todoItemDelete,
                        ),
                    ],
                  ),
                ),
              )
            ]),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: tdWhite,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10,
                            spreadRadius: 0.0),
                      ]),
                  child: TextField(
                    controller: _todoController,
                    decoration: const InputDecoration(
                      hintText: tdNewTodo,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(15),
                    ),
                  ),
                ),
              ),
              Container(
                color: tdBlue,
                margin: const EdgeInsets.only(right: 20, bottom: 20),
                child: ElevatedButton(
                  onPressed: () {
                    _todoAddItem(_todoController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: tdBlue,
                    minimumSize: const Size(60, 60),
                    elevation: 10,
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 40,
                    color: tdWhite,
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone!;
    });
  }

  void _todoItemDelete(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _todoAddItem(String todo) {
    setState(() {
      todosList.add(
        Todo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: todo,
        ),
      );
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<Todo>? result = [];
    if (enteredKeyword.isEmpty) {
      result = todosList;
    } else {
      result = todosList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundTodo = result!;
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Icon(
          Icons.menu,
          color: tdBlack,
          size: 30,
        ),
        Container(
          width: 40,
          height: 40,
          child: ClipRRect(
            child: Image.asset(tdUserImg),
            borderRadius: BorderRadius.circular(20),
          ),
        )
      ]),
    );
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: tdWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          hintText: 'Search',
          helperStyle: TextStyle(
            color: tdGrey,
          ),
          constraints: BoxConstraints(),
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          border: InputBorder.none,
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
        ),
      ),
    );
  }

  Widget allTodoString() {
    return Container(
      margin: const EdgeInsets.only(
        top: 50,
        bottom: 20,
      ),
      child: const Text(
        tdAllTodos,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
