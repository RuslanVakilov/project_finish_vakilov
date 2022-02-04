import 'contt_task.dart';
import 'draw_class.dart';
import 'package:flutter/material.dart';
import 'second_screen.dart';


class ContactViewPage extends StatelessWidget {
  final User user;

  ContactViewPage({required this.user});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("${user.name}"),
        ),
        drawer: buildDrawer(),
        body: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 50),
            child: Column(children: [
              const SizedBox(
                height: 12,
              ),
              Text('User name: ${user.username}',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(0, 0, 0, 60))),
              const SizedBox(
                height: 12,
              ),
              Text('E-mail: ${user.email}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16, color: Color.fromRGBO(0, 0, 0, 60))),
              const SizedBox(
                height: 12,
              ),
              Text('Phone number: ${user.phone}',
                  style: TextStyle(
                      fontSize: 16, color: Color.fromRGBO(0, 0, 0, 60))),
              Text('website: ${user.website}',
                  style: TextStyle(
                      fontSize: 16, color: Color.fromRGBO(0, 0, 0, 60))),
              Text('Address:\n  ${user.address?.street}\n  ${user.address?.suite}\n  ${user.address?.city}\n  ${user.address?.zipcode}',
                  style: TextStyle(
                      fontSize: 16, color: Color.fromRGBO(0, 0, 0, 60))),
              Text('GEO: lat: ${user.address?.geo?.lat},  lng: ${user.address?.geo?.lng}',
                  style: TextStyle(
                      fontSize: 16, color: Color.fromRGBO(0, 0, 0, 60))),
              Text('\n\nCompany name:  ${user.company?.name}\n  Catch phrase: ${user.company?.catchPhrase}\n  bs: ${user.company?.bs}',
                  style: TextStyle(
                      fontSize: 16, color: Color.fromRGBO(0, 0, 0, 60))),

              const SizedBox(
                height: 12,
              ),

              SizedBox(
                  width: 154,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return TasksPage(user.id);
                          },
                        ),
                      );
                    },
                    child: Text('Задачи'),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF0079D0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(36.0),
                      ),
                    ),
                  )),
            ])));
  }
}

