/*
The CategoryPage screen is used to add,view,update and delete category
 */

import 'package:contactapp/Controller/categorycontroller.dart';
import 'package:contactapp/Database/categoryhive.dart';
import 'package:contactapp/color/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});
  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String _inputText = '';
  final TextEditingController _editCategoryController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CategoryHive categoryHiveObj = CategoryHive();

  @override
  Widget build(BuildContext context) {
    CategoryController categoryControllerObj=Get.find<CategoryController>();
    categoryControllerObj.getData();
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text(
            "Create and Store Category",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: appBarBg,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          ),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                SizedBox(
                  width: 300,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _inputText = value;// Update the variable with the text entered by the user
                      });
                    },
                    decoration:  InputDecoration(
                      hintText: 'Enter your text here...',
                      labelText: 'Text Input',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3,
                          color: appBarBg,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                SizedBox(
                  width: 100,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: appBarBg, // Set background color here
                        padding: const EdgeInsets.all(8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: () async {
                        categoryHiveObj.addDataHive(_inputText, categoryControllerObj.count);
                        categoryControllerObj.count+=1;
                        //print("${_inputText} and ${categoryControllerObj.count}");
                        categoryControllerObj.getData();
                    
                      }, child: const Text("Save",style: TextStyle(color: Colors.white),)
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 300,
                  child: Obx(() =>ListView.builder(
                    itemCount: categoryControllerObj.data.length,
                    itemBuilder: (context, index) {
                        return Container(
                          color: categoryListBg,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children:[
                                       Padding(
                                         padding: const EdgeInsets.only(right: 60),
                                         child: Text("${categoryControllerObj.data[index].category}",style:const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                       ),
                                      InkWell(
                                          onTap: (){
                                            _editCategoryController.text=categoryControllerObj.data[index].category;
                                            showDialog<String>(context: context, builder: (BuildContext context)=>Dialog(
                                              child: SizedBox(
                                                height: 300,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(

                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      TextField(
                                                        controller: _editCategoryController,
                                                        decoration:  InputDecoration(
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              width: 3,
                                                              color: appBarBg,
                                                            ),
                                                          ),
                                                        ),
                                                      ),

                                                      Center(
                                                        child: ElevatedButton(
                                                            onPressed: (){
                                                              categoryHiveObj.editDataHive(_editCategoryController.text, index);
                                                              //print("${_inputText} and ${_count}");
                                                              categoryControllerObj.getData();
                                                              Navigator.of(context).pop();
                                                            }, child:const  Text("Save")),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ));
                                          },
                                          child:const  Image(image: AssetImage("assets/edit.png"), width: 50,height: 50,)),

                                      InkWell(
                                          onTap: (){
                                            showDialog<String>(context: context, builder: (BuildContext context)=>Dialog(
                                              child: SizedBox(
                                                height: 300,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const Center(child: Text("Are you Sure, U want to delete data??", style:TextStyle(fontWeight: FontWeight.bold),)),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Center(
                                                            child: ElevatedButton(
                                                                onPressed: (){
                                                                  Navigator.of(context).pop();
                                                                }, child: const Text("Cancel")),
                                                          ),
                                                          const SizedBox(width: 30,),
                                                          Center(
                                                            child: ElevatedButton(
                                                                onPressed: (){
                                                                  categoryHiveObj.deleteCategoryData(index);
                                                                  categoryControllerObj.getData();
                                                                  Navigator.of(context).pop();
                                                                }, child:const Text("Delete")),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ));
                                          }
                                          ,child:const Image(image: AssetImage("assets/delete.png"), width: 50,height: 50,)),
                                    ]
                                  ),
                                ),
                              ),
                              Divider(
                                color: categoryListSeparator, // Customize the color of the divider
                                thickness: 2, // Customize the thickness of the divider
                              )
                            ],
                          ),
                        );
                  },),
                                  ),
                )
              ],
            ),
          ),
        ));
  }
}
