import 'dart:io';
import 'dart:typed_data';

import 'package:contactapp/Controller/categorycontroller.dart';
import 'package:contactapp/Controller/contactcontroller.dart';
import 'package:contactapp/Database/contacthive.dart';
import 'package:contactapp/Images/getimages.dart';
import 'package:contactapp/Model/contactdata.dart';
import 'package:contactapp/color/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  GetImages getImagesObj = GetImages();
  ContactController contactControllerObj = Get.find<ContactController>();
  CategoryController categoryControllerObj = CategoryController();

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  showFilter(BuildContext context) async {
    late String categoryData;
    await categoryControllerObj.getData();
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => Dialog(
              child: SizedBox(
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SizedBox(
                          width: 250,
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 3,
                                  color: appBarBg,
                                ),
                              ),
                            ),
                            value: categoryControllerObj.data[0].category,
                            onChanged: (newValue) {
                              setState(() {
                                categoryData = newValue!;
                                print(categoryData);
                              });
                            },
                            items: categoryControllerObj.data.map((val) {
                              return DropdownMenuItem<String>(
                                value: val.category,
                                child: Text(val.category),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              //contactControllerObj.contacts.value=contactControllerObj.searchContacts(searchnameController.text) ;
                              contactControllerObj
                                  .filterContacts(categoryData);
                              Navigator.of(context).pop();
                            },
                            child: const Text("Enter")),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  showSearchDialog() {
    TextEditingController searchNameController = TextEditingController();

    showDialog<String>(
        context: context,
        builder: (BuildContext context) => Dialog(
              child: SizedBox(
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: TextFormField(
                          controller: searchNameController,
                          decoration: InputDecoration(
                            hintText: 'Enter name',
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
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              //contactControllerObj.contacts.value=contactControllerObj.searchContacts(searchnameController.text) ;
                              contactControllerObj
                                  .searchContacts(searchNameController.text);
                              Navigator.of(context).pop();
                            },
                            child: const Text("Enter")),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
  void showImageSelectDialog() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => Dialog(
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
                        onPressed: () {
                          contactControllerObj.setImageCamera();
                          Navigator.of(context).pop();
                        },
                        child: const Text("Camera")),
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          contactControllerObj.setImageGallery();
                          Navigator.of(context).pop();
                        },
                        child:const Text("Gallery")),
                  )
                ],
              ),
            ),
          ),
        ));
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Contact List",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: appBarBg,
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    contactControllerObj.getData();
                  },
                  child: const Icon(Icons.lock_reset_outlined)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    showSearchDialog();
                  },
                  child:const Image(image: AssetImage("assets/search.png"))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    showFilter(context);
                  },
                  child:const Image(image: AssetImage("assets/filter.png"))),
            ),
          ],
        ),
        body: FutureBuilder(
          future: contactControllerObj.getData(),
          builder: (context, snapshot) {
            var contact_data = contactControllerObj.contacts;
            if (snapshot.hasData) {
              return Obx(
                () => ListView.builder(
                  itemCount: contactControllerObj.contacts.length,
                  itemBuilder: (context, index) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 60),
                                  child: SizedBox(
                                    width: 60,
                                    child: contactControllerObj
                                                .contacts[index].image !=
                                            null
                                        ? Container(
                                            //color: Colors.blue,
                                            child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: ClipOval(
                                                child: Image.memory(
                                                  contactControllerObj
                                                      .contacts[index].image!,
                                                  width: 90,
                                                  height: 90,
                                                  fit: BoxFit.cover,
                                                )
                                              ),
                                            ),
                                          )
                                        : const FittedBox(
                                            fit: BoxFit.contain,
                                            child: Image(
                                              image: AssetImage(
                                                  "assets/default_user.png"),
                                              width: 90,
                                              height: 90,
                                            ),
                                          ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                      contactControllerObj
                                          .contacts[index].first_name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28),softWrap: true,),
                                ),
                                InkWell(
                                  onTap: () {
                                    contactControllerObj.imagePath.value="";
                                    firstnameController.text =
                                        contactControllerObj
                                            .contacts[index].first_name;
                                    lastnameController.text =
                                        contactControllerObj
                                            .contacts[index].last_name;
                                    emailController.text = contactControllerObj
                                        .contacts[index].email;
                                    mobileNoController.text =
                                        contactControllerObj
                                            .contacts[index].mobile_no;

                                    showDialog<String>(
                                        context: context,
                                        builder:
                                            (BuildContext context) => Dialog(

                                                  child: SingleChildScrollView(
                                                    child: SizedBox(
                                                      height: 800,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Obx(
                                                            ()=> ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100.0),
                                                                child: Container(
                                                                  alignment: Alignment.center,
                                                                    child: InkWell(
                                                                        onTap: () async {
                                                                          showImageSelectDialog();
                                                                          //print("${contactControllerObj.image_path}");
                                                                        },
                                                                        child: contactControllerObj.contacts[index].image != null || contactControllerObj.imagePath.isNotEmpty
                                                                            ? ClipOval(
                                                                              child: contactControllerObj.imagePath.isEmpty?Image.memory(
                                                                                contactControllerObj
                                                                                    .contacts[index].image!,
                                                                                width: 90,
                                                                                height: 90,
                                                                                fit: BoxFit.cover,
                                                                              ):Image.file(File("${contactControllerObj.imagePath}"),width: 90,height: 90,fit: BoxFit.cover,),
                                                                            )
                                                                            : const ClipOval(
                                                                              child: Image(
                                                                                  image: AssetImage("assets/default_user.png"),
                                                                                  width: 120,
                                                                                  height: 120,
                                                                                fit: BoxFit.cover,
                                                                                ),
                                                                            ))),
                                                              ),
                                                            ),
                                                            const SizedBox(height: 20,),
                                                            SizedBox(
                                                              width: 350,
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    firstnameController,
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintText:
                                                                      'First Name',
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      width: 3,
                                                                      color:
                                                                          appBarBg,
                                                                    ),
                                                                  ),
                                                                ),
                                                                validator:
                                                                    (value) {
                                                                  if (value!
                                                                      .isEmpty) {
                                                                    return 'Please enter First Name';
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            SizedBox(
                                                              width: 350,
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    lastnameController,
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintText:
                                                                      'Last Name',
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      width: 3,
                                                                      color:
                                                                          appBarBg,
                                                                    ),
                                                                  ),
                                                                ),
                                                                validator:
                                                                    (value) {
                                                                  if (value!
                                                                      .isEmpty) {
                                                                    return 'Please enter Last Name';
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            SizedBox(
                                                              width: 350,
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    mobileNoController,
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintText:
                                                                      'Mobile No',
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      width: 3,
                                                                      color:
                                                                          appBarBg,
                                                                    ),
                                                                  ),
                                                                ),
                                                                validator:
                                                                    (value) {
                                                                  if (value!
                                                                      .isEmpty) {
                                                                    return 'Please enter Mobile No';
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            SizedBox(
                                                              width: 350,
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    emailController,
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintText:
                                                                      'Email',
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      width: 3,
                                                                      color:
                                                                          appBarBg,
                                                                    ),
                                                                  ),
                                                                ),
                                                                validator:
                                                                    (value) {
                                                                  if (value!
                                                                      .isEmpty) {
                                                                    return 'Please enter Email';
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Center(
                                                                  child:
                                                                      ElevatedButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child:
                                                                              const Text("Cancel")),
                                                                ),
                                                                const SizedBox(width: 30,),
                                                                Center(
                                                                  child:
                                                                      ElevatedButton(
                                                                          onPressed:
                                                                              () async {
                                                                            ContactHive contactObj = ContactHive();
                                                                            Uint8List? currentImage;
                                                                            if(contactControllerObj.imagePath.value.isNotEmpty){
                                                                                currentImage=await getImagesObj.fileToUint8List(File(contactControllerObj.imagePath.value));
                                                                            }else{
                                                                              currentImage=contactControllerObj.contacts[index].image;
                                                                            }
                                                                            //current_image=contactControllerObj.image_path.value.isEmpty?contactControllerObj.contacts[index].image:await img_object.fileToUint8List(File(contactControllerObj.image_path.value));
                                                                            ContactData contact=ContactData(first_name: firstnameController.text, last_name: lastnameController.text,
                                                                                mobile_no: mobileNoController.text, email: emailController.text, category: contactControllerObj.contacts[index].category,image:currentImage);
                                                                            contactObj.update_contact(contact,index);
                                                                            contactControllerObj.getData();
                                                                            contactControllerObj.imagePath.value="";
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child:
                                                                              const Text("Update")),
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ));
                                  },
                                  child:const Image(
                                    image: AssetImage("assets/edit.png"),
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    ContactHive contactObj = ContactHive();
                                    contactObj.delete_contact(index);
                                    contactControllerObj.getData();
                                  },
                                  child: const Image(
                                    image: AssetImage("assets/delete.png"),
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 400,
                              child: Divider(
                                color: contactListSeparator,
                                // Customize the color of the divider
                                thickness:
                                    2, // Customize the thickness of the divider
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return const Text("data");
          },
        ));
  }
}
