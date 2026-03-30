// ignore_for_file: public_member_api_docs, sort_constructors_first
class PlayerEntity {
  final String id;
  final String name;
  final String? firstName;
  final String? lastName;
  final int? age;
  final String? nationality;
  final String? position;
  final String? photoUrl;
  final int? number;

  const PlayerEntity({
    required this.id,
    required this.name,
    this.firstName,
    this.lastName,
    this.age,
    this.nationality,
    this.position,
    this.photoUrl,
    this.number,
  });
}
