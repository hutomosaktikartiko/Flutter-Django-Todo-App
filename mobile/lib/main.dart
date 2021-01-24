import 'package:flutter/material.dart';
import 'package:mobile/pages/add_todo.dart';
import 'package:mobile/pages/todo_delete.dart';
import 'package:mobile/services/todo_services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todoP = Provider.of<TodoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: todoP.todos.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: ValueKey(todoP.todos[index].id),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {},
            confirmDismiss: (direction) async {
              final result = await showDialog(
                  context: context, builder: (_) => TodoDelete());

              if (result) {
                todoP.deleteTodo(todoP.todos[index]);
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text('Done'),
                          content: Text("Successfull delete!"),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("ok"))
                          ],
                        ));
                return true;
              }
              return result;
            },
            background: Container(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    )),
              ),
            ),
            child: ListTile(
                // trailing: IconButton(
                //     icon: Icon(Icons.delete, color: Colors.red),
                //     onPressed: () {
                //       // todoP.deleteTodo(todoP.todos[index]);
                //     }),
                title: Text(
                  todoP.todos[index].title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  todoP.todos[index].description,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                )),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => AddTodoPage()));
          }),
    );
  }
}
