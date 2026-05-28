class SpaceModel {
  final String id;
  final String name;
  final double budget;
  final int month;
  final int year;
  final String ownerId;
  final List members;

  SpaceModel({
    required this.id,
    required this.name,
    required this.budget,
    required this.month,
    required this.year,
    required this.ownerId,
    required this.members,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "budget": budget,
      "month": month,
      "year": year,
      "ownerId": ownerId,
      "members": members,
      "createdAt": DateTime.now(),
    };
  }
}