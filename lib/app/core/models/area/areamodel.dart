class AreaModel{
  AreaModel({
    this.id,
    this.name,
});
  final int? id;
  final String? name;
  factory AreaModel.fromJson(Map<String, dynamic> json) {
    return AreaModel(
      id: json['id'],
      name: json['name'],
    );
  }
}