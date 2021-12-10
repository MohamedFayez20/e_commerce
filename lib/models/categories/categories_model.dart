class CategoriesModel {
  bool? status;
  Data? data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  int? currentPage;
  List<CategoriesData> data = [];

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((v) {
      data.add(CategoriesData.fromJson(v));
    });
  }
}

class CategoriesData {
  int? id;
  String? name;
  String? image;

  CategoriesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
