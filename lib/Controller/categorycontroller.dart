import 'package:contactapp/Database/categoryhive.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController{

  CategoryHive categoryHiveObj=CategoryHive();
  var data=[].obs;
  late var count;

  getData() async{
     data.value = await categoryHiveObj.getCategoryData() ;
     count=data.length;
     count+=1;
  }
  setDataForContact(){
    data.value =  categoryHiveObj.getCategoryData() ;
  }

}