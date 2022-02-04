import 'cont_view.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class buildDrawer extends StatelessWidget {
  final _messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 132,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50.0))),
                    child:
                    Image.asset('assets/dart-logo.png'),
                  ),
//const Text("Навигация во Flutter")
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.one_k),
            title: const Text("Каталог"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactsPage()),
              );
            },
          ),
          ListTile(
              leading: const Icon(Icons.two_k),
              title: const Text("Корзина"),
              onTap: () {
                _messengerKey.currentState!.showSnackBar(
                    const SnackBar(content: Text('Переход в корзину')));
              }),
          const Divider(),
          const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text("Профиль"),
          ),
          ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Выйти"),
              onTap: () {

              }),
        ],
      ),
    );
  }
}

