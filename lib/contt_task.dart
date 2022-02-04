import 'package:flutter/material.dart';
import 'package:project_finish_vakilov/second_screen.dart';
import 'conta_det.dart';
import 'dart:convert';
import 'main.dart';
import 'package:project_finish_vakilov/draw_class.dart';
import 'package:http/http.dart' as http;

Future<List<Task>> _fetchTasksList(int ids) async {
  final url = "https://jsonplaceholder.typicode.com/todos?userId=";

  final response = await http.get(Uri.parse(url + ids.toString()));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((task) => Task.fromJson(task)).toList();
  } else {
    throw Exception('Список задач недосупен!');
  }
}

ListView _tasksListView(data) {
  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return _taskListTile(context, data[index]);
      });
}

ListTile _taskListTile(BuildContext context, Task task) => ListTile(
  title: Text("${task.title}",
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20,
      )),
  leading: CircleAvatar(
    child: Text("${task.id}"),
  ),
  trailing: Checkbox(value: task.completed, onChanged: null),
);

class TasksPage extends StatefulWidget {

  final int id = 1;

  const TasksPage(int? id, {Key? key}) : super(key: key);

  @override
  _TasksPageState createState() => _TasksPageState(id);
}

class _TasksPageState extends State<TasksPage> {

  final int id = 1;

  _TasksPageState(int id);

  late Future<List<Task>> futureTasksList;
  late List<Task> tasksListData;

  @override
  void initState() {
    super.initState();
    futureTasksList = _fetchTasksList(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Список задач'),
        ),
        drawer: buildDrawer(),
        body: Center(
            child: FutureBuilder<List<Task>>(
                future: futureTasksList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    tasksListData = snapshot.data!;
                    return _tasksListView(tasksListData);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  return const CircularProgressIndicator();
                }
            )
        )
    );
  }
}
