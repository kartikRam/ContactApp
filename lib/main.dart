import 'package:contactapp/Controller/categorycontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/adapters.dart';

import 'Controller/contactcontroller.dart';
import 'Model/categorydata.dart';
import 'Model/contactdata.dart';
import 'Screens/drawerbar.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CategoryDataAdapter());
  Hive.registerAdapter(ContactDataAdapter());
  Get.lazyPut(() => CategoryController());
  Get.lazyPut(() => ContactController());
  Box CategoryBox = await Hive.openBox<CategoryData>('CategoryBoxData');
  Box ContactBox = await Hive.openBox<ContactData>('ContactBoxData');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(

        body: DrawerBar()
      ),
    );
  }
}
