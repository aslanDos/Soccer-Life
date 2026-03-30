import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CountryEntity extends Equatable {
  final String name;
  final String code;
  final String flagUrl;

  const CountryEntity({
    required this.name,
    required this.code,
    required this.flagUrl,
  });

  CountryEntity copyWith({String? name, String? code, String? flagUrl}) {
    return CountryEntity(
      name: name ?? this.name,
      code: code ?? this.code,
      flagUrl: flagUrl ?? this.flagUrl,
    );
  }

  @override
  String toString() {
    return 'CountryEntity(name: $name, code: $code, flagUrl: $flagUrl)';
  }

  @override
  List<Object?> get props => [name, code, flagUrl];
}
