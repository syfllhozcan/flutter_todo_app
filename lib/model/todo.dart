class Todo {
  String? id;
  String? todoText;
  bool? isDone;
  Todo({required this.id, required this.todoText, this.isDone = false});

  static List<Todo> listItemFunc() {
    return listTodos;
  }
}

List<Todo> listTodos = [
  Todo(id: '1', todoText: 'Mail Addres', isDone: true),
  Todo(id: '2', todoText: 'Fail Detail', isDone: true),
  Todo(id: '3', todoText: 'Phone Nummber'),
  Todo(id: '4', todoText: 'Next Time'),
  Todo(id: '5', todoText: 'Hello World'),
  Todo(id: '6', todoText: 'Make to Video'),
  Todo(id: '7', todoText: 'Mail Addres', isDone: true),
  Todo(id: '8', todoText: 'Fail Detail', isDone: true),
  Todo(id: '9', todoText: 'Phone Nummber'),
  Todo(id: '10', todoText: 'Next Time'),
  Todo(id: '11', todoText: 'Hello World'),
  Todo(id: '12', todoText: 'Make to Video'),
];
