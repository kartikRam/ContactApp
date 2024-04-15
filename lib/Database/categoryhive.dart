/*
CategoryHive page is used to handle database operations with hive
*
* */
import 'package:contactapp/Model/categorydata.dart';
import 'package:hive/hive.dart';

class CategoryHive{

  addDataHive(String category,int key) async{
     Box CategoryBox = Hive.box<CategoryData>('CategoryBoxData');
      CategoryData obj=CategoryData(category: category);
      CategoryBox.add(obj);
  }
  editDataHive(String category,int index) async{
    Box CategoryBox = Hive.box<CategoryData>('CategoryBoxData');
    CategoryData obj=CategoryData(category: category);
    CategoryBox.putAt(index,obj);
  }
  getCategoryData() async {
    Box CategoryBox = Hive.box<CategoryData>('CategoryBoxData');

    var data = CategoryBox.values.toList();
    return data;
  }
  deleteCategoryData(index) async{
    Box CategoryBox = Hive.box<CategoryData>('CategoryBoxData');
    CategoryBox.deleteAt(index);
  }
}