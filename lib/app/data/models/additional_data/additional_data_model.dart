class AdditionalData {
  final int count;

  AdditionalData({required this.count});

  factory AdditionalData.fromJson(Map<String, dynamic> json) {
    return AdditionalData(count: json['count']);
  }
}