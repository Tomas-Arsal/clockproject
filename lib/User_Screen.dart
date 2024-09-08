import 'dart:developer';

import 'package:flutter/material.dart';

import 'Model_Screen.dart';




class User_Screen extends StatelessWidget {
  User_Screen({Key? key}) : super(key: key);
  List<UserModel> users =
  [
    UserModel(id: 1, name: 'Tomas Arsal', number: '01285246518') ,
    UserModel(id: 2, name: 'koko Arsal', number: '01254216584') ,
    UserModel(id: 3, name: ' Arsal', number: '012156158981') ,
    UserModel(id: 4, name: 'Michael kamal', number: '01282999472') ,
    UserModel(id: 5, name: 'Kerolos Maged', number: '0125418565') ,
    UserModel(id: 6, name: 'Mama ', number: '01215451254') ,

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: ListView.separated(
          itemBuilder: (context ,index) => UserItemModel(users[index]),
          separatorBuilder:(context , index) => Padding(
            padding: const EdgeInsetsDirectional.only(start: 8.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.indigoAccent,
            ),
          ),
          itemCount: users.length ,
      ) ,


    ) ;
  }
  Widget UserItemModel(UserModel users)  =>   Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      children: [
         CircleAvatar(
          radius: 30.0,
          child: Text(
            '${users.id}',
            style: const TextStyle(
              fontSize: 30.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Text(
              users.name,
              style: const TextStyle(
                fontSize: 30.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              users.number,
            ),
          ],
        ),
      ],
    ),
  );
}
