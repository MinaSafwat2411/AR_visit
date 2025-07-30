class ApiResponse<T> {
  final int statusCode;
  final String? status;
  final String message;
  final T? data;
  final LinksModel? links;
  final MetaModel? meta;

  ApiResponse({
    this.status,
    required this.message,
    this.data,
    required this.statusCode,
    this.links,
    this.meta,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      int statusCode,
      String message,
      ) {
    return ApiResponse(
      statusCode: json['status_code']?? 200,
      status: json['status'],
      message: json['message'] ?? "",
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      links: json['links'] != null ? LinksModel.fromJson(json['links']) : null,
      meta: json['meta'] != null ? MetaModel.fromJson(json['meta']) : null,
    );
  }
}

class LinksModel {
  Links? links;

  LinksModel({this.links});

  LinksModel.fromJson(Map<String, dynamic> json) {
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }
}

class Links {
  String? first;
  String? last;
  int? prev;
  int? next;

  Links({this.first, this.last, this.prev, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }
}

class MetaModel {
  Meta? meta;

  MetaModel({this.meta});

  MetaModel.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta(
      {this.currentPage,
        this.from,
        this.lastPage,
        this.path,
        this.perPage,
        this.to,
        this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

}
