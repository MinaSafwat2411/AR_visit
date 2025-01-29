import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static SharedPreferences? sharedPreferences;
  static init()async
  {
    sharedPreferences= await SharedPreferences.getInstance();
  }

  static dynamic getData({
    @required String? key,
  }){
    return  sharedPreferences!.get(key!);
  }
  
  static Future<bool> saveIntList({
    @required String? key,
    @required List<int>? value,
  }) async {
    List<String> stringList = value!.map((i) => i.toString()).toList();
    return await sharedPreferences!.setStringList(key!, stringList);
  }

  static List<int>? getIntList({
    @required String? key,
  }) {
    List<String>? stringList = sharedPreferences!.getStringList(key!);
    return stringList?.map((i) => int.parse(i)).toList();
  }

  static Future<bool> saveData({
    @required String? key,
    @required dynamic value,
  })async
  {
    if (value is bool) return await sharedPreferences!.setBool(key!, value);
    if (value is String) return await sharedPreferences!.setString(key!, value);
    if (value is int) return await sharedPreferences!.setInt(key!, value);
    if (value is double) return await sharedPreferences!.setDouble(key!, value);
    throw ArgumentError('Invalid type');
  }

  static Future<bool>  removeData({
    @required String? key,
  })async
  {
    return await sharedPreferences!.remove(key!);
  }
}