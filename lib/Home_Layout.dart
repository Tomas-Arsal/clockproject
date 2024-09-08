import 'dart:core';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'AppCubit.dart';
import 'Component.dart';
import 'cubit/cubitOfHome.dart';
class Home_Layout extends StatelessWidget {
  Home_Layout({Key? key}) : super(key: key);

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();


  var titleControler = TextEditingController();

  var timeControler = TextEditingController();

  var dataControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
           // if(state is appInsertDatabaseState) {
           //   Navigator.pop(context) ;
           // }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                title: Text(
                  cubit.titleScreen[cubit.currentIndex],
                ),
              ),
              body: ConditionalBuilder(
                condition: cubit.bodyScreens.isNotEmpty ,
                builder: (context) => cubit.bodyScreens[cubit.currentIndex],
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator()),
              ),
              floatingActionButton: FloatingActionButton(
                  onPressed: ()  async {
                    if (cubit.isBottomSheetShawn) {
                      if (formKey.currentState!.validate()) {
                        cubit
                            .insertToDatabase(
                          title: titleControler.text,
                          time: timeControler.text,
                          date: dataControler.text,
                        )
                            .then((value) {
                          Navigator.pop(context);
                          cubit.changeBottomSheetState(
                            icon: Icons.edit,
                            isShow: false,
                          );
                        });
                      }
                    } else {
                      scaffoldKey.currentState
                          ?.showBottomSheet(
                            (context) => Container(
                              color: Colors.grey,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      defaultTextFormField(
                                        controller: titleControler,
                                        textInputType: TextInputType.text,
                                        label: 'Title Box',
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'value is empty plz put anything';
                                          }
                                          return null;
                                        },
                                        prefix: Icons.title,
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      defaultTextFormField(
                                        controller: timeControler,
                                        textInputType: TextInputType.text,
                                        label: 'Time Box',
                                        ontap: () {
                                          showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          ).then((value) {
                                            timeControler.text = value!
                                                .format(context)
                                                .toString();
                                            print(value.format(context));
                                          });
                                        },
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'value is empty plz put anything';
                                          }
                                          return null;
                                        },
                                        prefix: Icons.watch_later,
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      defaultTextFormField(
                                        controller: dataControler,
                                        textInputType: TextInputType.text,
                                        label: 'Data Box',
                                        ontap: () {
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime.parse(
                                                      '2022-10-25'))
                                              .then((value) {
                                            dataControler.text =
                                                DateFormat.yMMMd()
                                                    .format(value!);
                                          });
                                        },
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'value is empty plz put anything';
                                          }
                                          return null;
                                        },
                                        prefix: Icons.calendar_month,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                          .closed
                          .then((value) {
                        cubit.changeBottomSheetState(
                          icon: Icons.edit,
                          isShow: false,
                        );
                      });
                      cubit.changeBottomSheetState(
                        icon: Icons.add,
                        isShow: true,
                      );
                    }
                  },
                  child: Icon(
                    cubit.fabIcon,
                  )),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeIndex(index);
                  print(index);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.add,
                    ),
                    label: 'Menu',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.check_box,
                    ),
                    label: 'Cheked',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.archive,
                    ),
                    label: 'Archeved',
                  ),
                ],
              ));
        },
      ),
    );
  }
}
