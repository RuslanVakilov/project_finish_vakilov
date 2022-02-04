import 'package:flutter/material.dart';
import 'second_screen.dart';
import 'conta_det.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'main.dart';
import 'draw_class.dart';

late List<User> users = [];

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);


  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {

  final url = "https://jsonplaceholder.typicode.com/users";

  Future<void> fetchPosts() async {
    try {

      final response = await get(Uri.parse(url));
      List jsonData = jsonDecode(response.body);

      setState(() {
// Заполняем данные
        for (var i = 0; i < jsonData.length; i++) {
          final user = jsonData[i];

          Geo geo = user(
              lat: "-37.3159"/*user["address"]["geo"]["lat"]*/,
              lng: "81.1496"/*user["address"]["geo"]["lng"]*/
          );

          Address address = user(
              street: user["address"]["street"],
              suite: user["address"]["suite"],
              city: user["address"]["city"],
              zipcode: user["address"]["zipcode"],
              geo: geo);

          Company company = user(
              name: user["company"]["name"],
              catchPhrase: user["company"]["catchPhrase"],
              bs: user["company"]["bs"]
          );

          User record = user(
              id: user["id"],
              name: user["name"],
              username: user["username"],
              email: user["email"],
              address: address,
              phone: user["phone"],
              website: user["website"],
              company: company
          );

          users.add(record);
        }
      });

    } catch (err){throw Exception('Failed to load json $err');}

  }

  @override
  void initState(){
    super.initState();

    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Posts"),
        ),
        drawer: buildDrawer(),
        body: Container(
          child: ContactList(users),
        )
    );
  }
}

class ContactList extends StatelessWidget {
  final List _users;

  ContactList(this._users);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemCount: users.length,
      itemBuilder: _buildContacts,
    );
  }

  Widget _buildContacts(context, index) {
    return ContactItem(_users[index]);
  }

}

class ContactItem extends StatelessWidget {
  const ContactItem(this.user);

  final User user;

  Widget _buildTiles(BuildContext context, User user) {
    return ListTile(
      title: Text(user.name),
      subtitle: Text("email ${user.email}"),
      leading: CircleAvatar(
        child: Text("${user.id}"),
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
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(context, user);
  }
}


