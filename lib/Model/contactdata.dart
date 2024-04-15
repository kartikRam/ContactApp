

import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'contactdata.g.dart';

@HiveType(typeId: 5)
class ContactData{

  ContactData(
      {required this.first_name,required this.last_name,required this.mobile_no,
        required this.email, required this.category,required this.image});

  @HiveField(0)
  String first_name;


  @HiveField(1)
  String last_name;


  @HiveField(2)
  String mobile_no;


  @HiveField(3)
  String email;

  @HiveField(4)
  String category;

  @HiveField(5)
  Uint8List? image;

}