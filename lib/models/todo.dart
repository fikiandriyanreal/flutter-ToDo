class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(
        id: '01',
        todoText: 'Mencuci',
      ),
      ToDo(
        id: '02',
        todoText: 'Mencuci',
      ),
      ToDo(
        id: '03',
        todoText: 'Mencuci',
      ),
      ToDo(
        id: '04',
        todoText: 'Mencuci',
      ),
      ToDo(
        id: '05',
        todoText: 'Mencuci',
      ),
      ToDo(
        id: '06',
        todoText: 'Mencuci',
      ),
    ];
  }
}
