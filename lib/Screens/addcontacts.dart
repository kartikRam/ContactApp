/*
The AddContact Screen is used to add contacts to the hive database
the addcontact class has form to add contacts
 */

import 'dart:io';
import 'dart:typed_data';
import 'package:contactapp/Controller/categorycontroller.dart';
import 'package:contactapp/Controller/contactcontroller.dart';
import 'package:contactapp/Database/contacthive.dart';
import 'package:contactapp/Images/getimages.dart';
import 'package:contactapp/Model/contactdata.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../color/color.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});
  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstnameController=TextEditingController();
  TextEditingController lastnameController=TextEditingController();
  TextEditingController mobileNoController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  late String _firstname;
  late String _lastname;
  late String _mobileNo;
  late String _email;
  late String _categoryData;
  ContactController contactControllerObj=Get.find<ContactController>();
  CategoryController categoryController= CategoryController();

  //reset form method is used to reset the form
  void _resetForm() {
    _formKey.currentState?.reset(); // Reset form fields
    firstnameController.clear(); // Clear text field controllers
    lastnameController.clear(); //Clear lastname field controller
    mobileNoController.clear(); //Clear mobileNo field controller
    emailController.clear(); //Clear email field controller
  }
  //Dialog method to show custom message
  void showDialogBox(BuildContext context,String message){
    showDialog<String>(context: context, builder: (BuildContext context)=>Dialog(
      child: SizedBox(
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text(message, style:const TextStyle(fontWeight: FontWeight.bold),)),
              Center(
                    child: ElevatedButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        }, child: const Text("OK")),
                  )
            ],
          ),
        ),
      ),
    ));
  }
  //Dialog method to view image selection options
  void showImageSelectDialog(BuildContext context){
    showDialog<String>(context: context, builder: (BuildContext context)=>Dialog(
      child: SizedBox(
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ElevatedButton(
                    onPressed: (){
                      contactControllerObj.setImageCamera();
                      Navigator.of(context).pop();
                    }, child: const Text("Camera")),
              ),
              Center(
                child: ElevatedButton(
                    onPressed: (){
                      contactControllerObj.setImageGallery();
                      Navigator.of(context).pop();
                    }, child: const Text("Gallery")),
              )
            ],
          ),
        ),
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
    contactControllerObj.imagePath.value="";
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Contacts",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: appBarBg,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: categoryController.getData(),
        builder: (context, snapshot) {
          if(categoryController.data.isNotEmpty) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top:100),
                child: Center(
                  child: Form(
                    key:_formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(
                          ()=>
                              ClipRRect(borderRadius: BorderRadius.circular(100.0),
                              child:InkWell(
                              onTap: () async{
                                showImageSelectDialog(context);
                                }
                              ,child: contactControllerObj.imagePath.isNotEmpty
                              ?ClipOval(child: Image.file(File("${contactControllerObj.imagePath}")
                                ,width: 100,height: 80,fit: BoxFit.cover,))
                              :const ClipOval(child: Image(image:AssetImage("assets/default_user.png")
                                ,width: 100,height: 80,fit: BoxFit.cover,))),
                        ),
                        ),
                        const SizedBox(height:50),
                        SizedBox(
                          width: 350,
                          child: TextFormField(
                            controller: firstnameController,
                            decoration: InputDecoration(
                              hintText: 'First Name',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 3,
                                  color: appBarBg,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter First Name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _firstname = value!;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 350,
                          child: TextFormField(
                            controller: lastnameController,
                            decoration: InputDecoration(
                              hintText: 'Last Name',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 3,
                                  color: appBarBg,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Last Name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _lastname = value!;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 350,
                          child: TextFormField(
                            controller: mobileNoController,
                            decoration: InputDecoration(
                              hintText: 'Mobile No',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 3,
                                  color: appBarBg,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Mobile No';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _mobileNo = value!;
                            },
                          ),
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 350,
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 3,
                                  color: appBarBg,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Email';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _email = value!;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 350,
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              hintText: 'Email',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 3,
                                  color: appBarBg,
                                ),
                              ),
                            ),
                            value: categoryController.data[0].category,
                            onChanged: (newValue) {
                              setState(() {
                                _categoryData = newValue!;
                                //print(_category_data);
                              });
                            },
                            items: categoryController.data
                                .map((val) {
                              return DropdownMenuItem<String>(
                                value: val.category,
                                child: Text(val.category),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: appBarBg, // Set background color here
                              padding: const EdgeInsets.all(8.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState?.save();
                                ContactHive contactObj = ContactHive();
                                GetImages getImages=GetImages();
                                File file = File(contactControllerObj.imagePath.value);
                                Uint8List? uint8list = await getImages.fileToUint8List(file);
                                ContactData contact = ContactData(first_name: _firstname, last_name: _lastname, mobile_no: _mobileNo, email: _email, category: _categoryData, image: uint8list!);
                                contactObj.add_contact(contact);
                                contactControllerObj.imagePath.value="";
                                _resetForm();
                                showDialogBox(context,"Data Saved Successfully");
                              }else{
                                showDialogBox(context,"Please Enter all Data");
                              }
                            }, child: const Text("Save",style: TextStyle(color: Colors.white),)
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return const Text("Counting");
    },)
    );
  }
}
