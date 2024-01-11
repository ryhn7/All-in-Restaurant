import 'package:hive/hive.dart';

part 'review.g.dart';

@HiveType(typeId: 4)


class Review {
  Review({required this.id, required this.name, required this.review, required this.date});

  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String review;
  @HiveField(3)
  String date;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        review: json["review"] ?? "",
        date: json["date"] ?? "",
      );

  Map<String, dynamic> toJson() => {"id": id, "name": name, "review": review, "date": date};
}