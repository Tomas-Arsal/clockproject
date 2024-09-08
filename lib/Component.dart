
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AppCubit.dart';


Widget defaultButtom({
  required background,
  required Width,
  double radious = 10.0,
  required VoidCallback function,
  required String text,
}) =>
    Container(
      width: Width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radious),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );



Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType textInputType,
  required String label,
  required validate,
  ontap,
  onchanged,
  required IconData prefix,
  IconData? suffix,
  suffixPressed,
  bool isPassword = false,
}) =>
    TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: textInputType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
      validator: validate,
      onTap: ontap,
      onChanged: onchanged,
    );

Widget buildMenuItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 40.0,
            left: 30.0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.blue,
                child: Text(
                  '${model['time']}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${model['title']}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      '${model['date']}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 5.0,
              ),
              IconButton(
                onPressed: () {
                  AppCubit.get(context).updateData(
                    status: 'check',
                    id: model['id'],
                  );
                },
                icon: Icon(Icons.check),
              ),
              IconButton(
                onPressed: () {
                  AppCubit.get(context).updateData(
                    status: 'archive',
                    id: model['id'],
                  );
                },
                icon: Icon(Icons.archive),
              ),
            ],
          ),
        ),
      ),
      onDismissed: (Direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
    );

Widget tasksBuilder({required List<Map> tasks}) => ConditionalBuilder(
      condition: tasks.length > 0,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) => buildMenuItem(tasks[index], context),
        separatorBuilder: (context, index) => separatorBuilderItem() ,
        itemCount: tasks.length,
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.menu,
              size: 100.0,
              color: Colors.grey,
            ),
            Text(
              'No Tasks Yet , Please Add Some Tasks',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w900,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );

Widget separatorBuilderItem () => Padding(
  padding: const EdgeInsets.all(8.0),
  child: Container(
    color: Colors.brown,
    height: 5.0,
  ),
) ;

Widget articleBuilder(list , context) => ConditionalBuilder(
  condition: list.length > 0,
  builder: (context) =>
      ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) =>
            buildMenuItem(list[index] , context),
        separatorBuilder: (context, index) => separatorBuilderItem(),
        itemCount: list.length,
      ),
  fallback: (context) =>
  const Center(child: CircularProgressIndicator()),
);


void navigateTo(context , Widget)
{
  Navigator.push(
    context,
  MaterialPageRoute(builder:(context) => Widget ) ,
  ) ;
}

void navigateAndFinished(context , Widget)
{
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder:(context) => Widget ) ,
          (Route<dynamic> route) => false
  );
}