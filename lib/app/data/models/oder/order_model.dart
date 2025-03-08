class OrderModel {
  OrderModel({
    this.ids
});
  List<int>? ids;

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderIds']= ids;
    return data;
  }
}