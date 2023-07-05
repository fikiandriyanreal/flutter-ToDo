import 'package:flutter/material.dart';
import 'package:todo_app/screens/popup.dart';

import '../models/todo.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  content: Container(
                height: 120,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextField(
                        controller: _todoController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Add a new task',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _addToDoItem(_todoController.text);
                            },
                            child: Text('Submit'),
                            style: ElevatedButton.styleFrom(
                              // Change the minimumSize property to adjust the button size
                              minimumSize: Size(80, 40),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel'),
                            style: ElevatedButton.styleFrom(
                              // Change the minimumSize property to adjust the button size
                              minimumSize: Size(80, 40),
                            ),
                          )
                        ],
                      )
                    ]),
              ));
            },
          );
        },
        child: Icon(Icons.add),
        heroTag: null,
        elevation: 6.0,
        backgroundColor: tdBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      drawer: NavigationDrawer(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 50,
                          bottom: 20,
                        ),
                        child: Text(
                          'All ToDos',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      for (ToDo todoo in _foundToDo.reversed)
                        ToDoItem(
                          todo: todoo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
      ));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  Widget searchBox() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: TextField(
              onChanged: (value) => _runFilter(value),
              decoration:
                  InputDecoration(hintText: 'Search', border: InputBorder.none),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        )
      ]),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black, // Change the drawer icon color to black
      ),
      title: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        AvatarIcon(
          imagePath: 'assets/images/avatar.jpg',
          size: 64.0,
        ),
      ]),
    );
  }
}

class AvatarIcon extends StatelessWidget {
  final String imagePath;
  final double size;

  AvatarIcon({required this.imagePath, this.size = 48.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage('assets/images/avatar.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: (tdBlue)),
            accountName: Text(
              "Fiki Andriyan",
              style: TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
            accountEmail: Text(
              "fikiandriyanreal@gmail.com",
              style: TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.jpg'),
            ),
          ),
          ListTile(
            leading: Theme(
              data: Theme.of(context).copyWith(
                iconTheme: IconThemeData(
                  color: Colors.blue, // Set the desired icon color here
                ),
              ),
              child: Icon(Icons.home),
            ),
            title: Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            leading: Theme(
              data: Theme.of(context).copyWith(
                iconTheme: IconThemeData(
                  color: Colors.blue, // Set the desired icon color here
                ),
              ),
              child: Icon(Icons.settings),
            ),
            title: Text('Settings'),
            onTap: () {
              Navigator.pushNamed(context, '/popup');
              // Add your logic here
            },
          ),
          ListTile(
            leading: Theme(
              data: Theme.of(context).copyWith(
                iconTheme: IconThemeData(
                  color: Colors.blue, // Set the desired icon color here
                ),
              ),
              child: Icon(Icons.info),
            ),
            title: Text('About'),
            onTap: () {
              // Add your logic here
            },
          ),
        ],
      ),
    );
  }
}
