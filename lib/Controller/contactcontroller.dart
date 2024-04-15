/* ContactController class is used to maintain state
* of the data which is used to update the page
* */

import 'dart:io';
import 'package:contactapp/Database/contacthive.dart';
import 'package:contactapp/Images/getimages.dart';
import 'package:get/get.dart';


class ContactController extends GetxController{
  ContactHive contactHiveObj=ContactHive();
  var contacts=[].obs;
  late var count;
  //File image=File("assets/search.png") ;
  var imagePath="".obs;

  getData() async{
    contacts.value = await contactHiveObj.get_contact_data() ;
    //print(contacts.length);
    return contacts;
  }

  // Search contacts by name or email
   searchContacts(String query) async {
     // contacts.clear();
     // await get_data();
    var tempData= contacts.where((contact) =>
    contact.first_name.toLowerCase().contains(query.toLowerCase())).toList();
    contacts.value=tempData;
  }

  filterContacts(String query) async {
    // contacts.clear();
    // await get_data();
    var tempData= contacts.where((contact) =>
        contact.category.toLowerCase().contains(query.toLowerCase())).toList();
    contacts.value=tempData;
  }
  setImageCamera() async{
    GetImages obj=GetImages();
    File? img = await obj.captureImageFromCamera();
    imagePath.value=img!.path;
    //print(image_path);
    return "success";
  }
  setImageGallery() async{
    GetImages obj=GetImages();
    File? img = await obj.getImageFromGallery();
    imagePath.value=img!.path;
    //print(image_path);
    return "success";
  }
}