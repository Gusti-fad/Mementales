import 'package:flutter/material.dart';

class SpaceModel {
  final String id;

  final String name;

  final String description;

  final double balance;

  final double spendingLimit;

  final String limitCycle;

  final String ownerId;

  final List<dynamic> members;

  final String? coverUrl;

  final Color color;

  const SpaceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.balance,
    required this.spendingLimit,
    required this.limitCycle,
    required this.ownerId,
    required this.members,
    required this.color,
    this.coverUrl,
  });

  factory SpaceModel.fromMap(
    Map<String, dynamic> map,
    String id,
  ) {
    return SpaceModel(
      id: id,

      name: map["name"] ?? "",

      description:
          map["description"] ?? "",

      balance:
          ((map["balance"] ??
                      map["budget"] ??
                      0)
                  as num)
              .toDouble(),

      spendingLimit:
          ((map["spendingLimit"] ??
                      map["budget"] ??
                      0)
                  as num)
              .toDouble(),

      limitCycle:
          map["limitCycle"] ??
              map["budgetPeriod"] ??
              "Monthly",

      ownerId:
          map["ownerId"] ?? "",

      members: List<dynamic>.from(
        map["members"] ?? [],
      ),

      coverUrl:
          map["coverUrl"],

      color: Color(
        map["color"] ??
            4294940672,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,

      "description":
          description,

      "balance": balance,

      "spendingLimit":
          spendingLimit,

      "limitCycle":
          limitCycle,

      "ownerId": ownerId,

      "members": members,

      "coverUrl": coverUrl,

      "color": color.value,

      "createdAt":
          DateTime.now(),
    };
  }
}