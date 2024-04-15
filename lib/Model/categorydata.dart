

import 'package:hive/hive.dart';

part 'categorydata.g.dart';

@HiveType(typeId: 4)
class CategoryData{

  CategoryData({required this.category});

  @HiveField(0)
  String category;
}