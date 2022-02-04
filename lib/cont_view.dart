import 'package:flutter/material.dart';
import 'second_screen.dart';
import 'conta_det.dart';
import 'dart:convert';
import 'main.dart';
import 'draw_class.dart';
import 'package:http/http.dart' as http;

Future<List<User>> _fetchUsersList() async {
  final url = "https://jsonplaceholder.typicode.com/users";

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((user) => User.fromJson(user)).toList();
  } else {
    throw Exception('Ошиба доступа!');
  }
}

ListView _usersListView(data) {

  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return _userListTile(context, data[index]);
      });
}

ListTile _userListTile(BuildContext context, User user) => ListTile(
  title: Text("${user.name}",
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20,
      )),
  subtitle: Text("${user.email}"),
  leading: CircleAvatar(
    child: Text((user.name ?? '-')[0]),
  ),
  trailing: Icon(Icons.local_post_office),
  onTap: () {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return ContactViewPage(user: user,);
        },
      ),
    );

  },
);



class ContactsPage extends StatefulWidget {

  const ContactsPage({Key? key}) : super(key: key);

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  late Future<List<User>> futureUsersList;
  late List<User> usersListData;

  @override
  void initState() {
    super.initState();
    futureUsersList = _fetchUsersList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          title: Text('Пользователи'),
        ),
        drawer: buildDrawer(),
        body: Center(
            child: FutureBuilder<List<User>>(
                future: futureUsersList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    usersListData = snapshot.data!;
                    return _usersListView(usersListData);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  return const CircularProgressIndicator();
                })
        )
    );
  }
}

