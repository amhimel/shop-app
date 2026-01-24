import 'dart:convert';

List<Sneakers> sneakersFromJson(String str) => List<Sneakers>.from(json.decode(str).map((x) => Sneakers.fromJson(x)));

String sneakersToJson(List<Sneakers> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sneakers {
  final String id;
  final String name;
  final String title;
  final String category;
  final List<String> imageUrl;
  final String oldPrice;
  final List<Size> sizes;
  final String price;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Sneakers({
    required this.id,
    required this.name,
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.oldPrice,
    required this.sizes,
    required this.price,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Sneakers.fromJson(Map<String, dynamic> json) => Sneakers(
    id: json["_id"] as String? ?? '',
    name: json["name"] as String? ?? 'Unknown',
    title: json["title"] as String? ?? 'Unknown',
    category: json["category"] as String? ?? 'General',
    imageUrl: json['imageUrl'] != null
        ? List<String>.from(json['imageUrl'] as List)
        : [],
    oldPrice: json["oldPrice"] as String? ?? "5",
    sizes: List<Size>.from(json["sizes"].map((x) => Size.fromJson(x))),
    price: json["price"] as String? ?? "5",
    description: json["description"] as String? ?? '',
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "title": title,
    "category": category,
    "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
    "oldPrice": oldPrice,
    "sizes": List<dynamic>.from(sizes.map((x) => x.toJson())),
    "price": price,
    "description": description,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

class Size {
  final String size;
  final bool isSelected;
  final String id;

  Size({
    required this.size,
    required this.isSelected,
    required this.id,
  });

  factory Size.fromJson(Map<String, dynamic> json) => Size(
    size: json["size"],
    isSelected: json["isSelected"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "size": size,
    "isSelected": isSelected,
    "_id": id,
  };
}
