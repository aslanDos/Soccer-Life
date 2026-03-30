import 'package:soccer_life/features/players/domain/entity/player_entity.dart';

class PlayerModel extends PlayerEntity {
  PlayerModel({
    required super.id,
    required super.name,
    required super.firstName,
    required super.lastName,
    required super.age,
    required super.nationality,
    required super.position,
    required super.photoUrl,
  });

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      id: json['id'].toString(),
      name: json['name'],
      firstName: json['name'], // API не даёт firstname отдельно
      lastName: '', // тоже нет
      age: json['age'] ?? 0,
      nationality: '', // нет в squads
      position: json['position'],
      photoUrl: json['photo'],
    );
  }
}
