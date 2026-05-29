import 'package:flutter/material.dart';

class SpaceModel {
  final String id;
  final String name;
  final String description;
  final double budget;
  final int month;
  final int year;
  final String budgetPeriod;
  final String type;
  final Color color;
  final String ownerId;
  final List<dynamic> members;
  final List<dynamic> wishlist;
  final String? coverUrl;

  SpaceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.budget,
    required this.month,
    required this.year,
    required this.budgetPeriod,
    required this.type,
    required this.color,
    required this.ownerId,
    required this.members,
    required this.wishlist,
    this.coverUrl,
  });

  factory SpaceModel.fromMap(
    Map<String, dynamic> map,
    String docId,
  ) {

    return SpaceModel(
      id: docId,
      name:
          map["name"] ?? "",
      description:
          map["description"] ?? "",
      budget:
          ((map["budget"] ?? 0)
                  as num)
              .toDouble(),
      month:
          map["month"] ?? 1,
      year:
          map["year"] ?? 2026,
      budgetPeriod:
          map["budgetPeriod"] ??
              "Monthly",
      type:
          map["type"] ??
              "Personal",
      color:
          Color(
        map["color"] ??
            0xFF5B8CFF,
      ),
      ownerId:
          map["ownerId"] ?? "",
      members:
          map["members"] ?? [],
      wishlist:
          map["wishlist"] ?? [],
      coverUrl:
          map["coverUrl"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name":
          name,
      "description":
          description,
      "budget":
          budget,
      "month":
          month,
      "year":
          year,
      "budgetPeriod":
          budgetPeriod,
      "type":
          type,
      "color":
          color.value,
      "ownerId":
          ownerId,
      "members":
          members,
      "wishlist":
          wishlist,
      "coverUrl":
          coverUrl,
      "createdAt":
          DateTime.now(),
    };
  }
}