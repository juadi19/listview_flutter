// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Material App',
//       home: Scaffold(
//           appBar: AppBar(
//             title: Text('Material App Bar'),
//           ),
//           floatingActionButton: FloatingActionButton(
//             backgroundColor: Colors.green,
//             child: Icon(Icons.add),
//             onPressed: (

//             ) {},
//           ),
//           body: ListView.builder(
//               itemCount: _personas.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return ListTile(
//                   title: Text(
//                       _personas[index].name + ' ' + _personas[index].lastName),
//                   subtitle: Text(_personas[index].account),
//                   leading: CircleAvatar(
//                     child: Text(_personas[index].name.substring(0, 1)),
//                   ),
//                   trailing: Icon(Icons.arrow_forward_ios),
//                 );
//               })),
//     );
//   }
// }

// List<Persona> _personas = [Persona('Pedro', 'Picapiedra', '20184613')];

// class Persona {
//   String name;
//   String lastName;
//   String account;

//   Persona(this.name, this.lastName, this.account);
// }

import 'package:flutter/material.dart';
import 'package:listview_flutter/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: HomeScreen(),
    );
  }
}
