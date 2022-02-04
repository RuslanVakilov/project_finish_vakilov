import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'cont_view.dart';



void main() => runApp(new MaterialApp(
  home: new MyApp(),
));

class MyApp extends StatelessWidget {
  late String _login;
  late String _password;
  final _sizeTextBlack = const TextStyle(fontSize: 20.0, color: Colors.black);
  final _sizeTextWhite = const TextStyle(fontSize: 20.0, color: Colors.white);
  final formKey = new GlobalKey<FormState>();
  final _messengerKey= GlobalKey<ScaffoldMessengerState>();
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return new MaterialApp(
      scaffoldMessengerKey: _messengerKey,
      home: new Scaffold(

        appBar: AppBar(
          title: const Text('Menu'),
          actions: <Widget>[
            IconButton(
                tooltip: 'Баланс',
                onPressed: () {},
                icon: const Icon(Icons.account_balance)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
            TextButton(
              onPressed: (){},
              child: const Text('Профиль'),
            ),
          ],
        ),


        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Container (
                  height: 200,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50.0))
                        ),
                        child: Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Google-flutter-logo.svg/1024px-Google-flutter-logo.svg.png"),
                      ),
                      const Text('Навигация во Flutter'),
                      const Divider(
                        height: 20,
                        thickness: 1,
                        indent: 5,
                        endIndent: 0,
                        color: Colors.black,
                      ),

                    ],
                  ),

                ),
              ),

              ListTile(
                leading: const Icon(Icons.two_k),
                title: const Text('Корзина'),
                onTap: (){
                  _messengerKey.currentState!.showSnackBar(
                      const SnackBar(content: Text('Переход в корзину')));
                },
              ),
              const Divider(
                height: 20,
                thickness: 1,
                indent: 5,
                endIndent: 0,
                color: Colors.black,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text('Профиль'),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Настройки'),
                onTap: (){
                  _messengerKey.currentState!.showSnackBar(
                      const SnackBar(content: Text('Переход в настройки')));
                },
              ),

            ],
          ),
        ),

        body: new Center(
          child: new Form(
              key: formKey,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    child: new TextFormField(
                      decoration: new InputDecoration(labelText: "Login"),
                      keyboardType: TextInputType.emailAddress,
                      maxLines: 1,
                      style: _sizeTextBlack,
                      onSaved: (val) => _login = val!,
                      validator: (val) =>
                      !val!.contains("89999999999") ? 'Not a valid email.' : null,
                    ),
                    width: 200.0,
                  ),
                  new Container(
                    child: new TextFormField(
                      decoration: new InputDecoration(labelText: "Password"),
                      obscureText: true,
                      maxLines: 1,
                      validator: (val) =>
                      !val!.contains("password") ? 'Password too short.' : null,
                      onSaved: (val) => _password = val!,
                      style: _sizeTextBlack,
                    ),
                    width: 200.0,
                    padding: new EdgeInsets.only(top: 10.0),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(top: 25.0),
                    child: new MaterialButton(
                      onPressed: submit,
                      color: Theme.of(context).accentColor,
                      height: 50.0,
                      minWidth: 150.0,
                      child: new Text(
                        "LOGIN",
                        style: _sizeTextWhite,
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  void submit() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      performLogin();
    }
  }

  void performLogin() {
    hideKeyboard();
    Navigator.push(
        _context,
        new MaterialPageRoute(
            builder: (context) => new RedirectionScreen(_login, _password)));
  }

  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}

Widget buttonBuilder(
    String buttonText, BuildContext context, Widget callbackName) {
  return new RaisedButton(
      child: Text(buttonText),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => callbackName));
      });
}

class RedirectionScreen extends StatelessWidget {
  RedirectionScreen(String _login, String _password);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(title: Text("Авторизация")),
        body: Center(
          child: new Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              buttonBuilder('Подтвердить вход', context, ContactsPage()),
            ],
          ),
        ));
  }
}