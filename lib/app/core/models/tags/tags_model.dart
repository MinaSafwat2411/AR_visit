import 'package:get/get.dart';

class TagsModel {
  String name;
  String nameAr;
  int? value;
  String? type;
  RxBool isSelected = false.obs;

  TagsModel({required this.name, this.value, this.type,required this.nameAr,required this.isSelected});
}