//
// import 'package:flutter/cupertino.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class CacheHelper{
//   static SharedPreferences? sharedpreferences;
//   static init()async
//   {
//     sharedpreferences= await SharedPreferences.getInstance();
//   }
//   static Future<bool> boolputData({
//     @required String? key,
//     @required bool? value
//   })async{
//     return await sharedpreferences!.setBool(key!, value!);
//   }
//   static dynamic getData({
//     @required String? key,
//   }){
//     return  sharedpreferences!.get(key!);
//   }
//   static Future<bool> SaveData({
//     @required String? key,
//     @required dynamic value,
//   })async
//   {
//     if (value is bool) return await sharedpreferences!.setBool(key!, value);
//     if (value is String) return await sharedpreferences!.setString(key!, value);
//     if (value is int) return await sharedpreferences!.setInt(key!, value);
//     if (value is double) return await sharedpreferences!.setDouble(key!, value);
//
//     throw ArgumentError('Invalid type');
//
//
//   }
//   static Future<bool>  removeData({
//     @required String? key,
//
//   })async
//   {
//     return await sharedpreferences!.remove(key!);
//   }
// }
