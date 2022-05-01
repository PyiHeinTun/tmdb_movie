import 'package:equatable/equatable.dart';

class Person extends Equatable {
  final int id;
  final String profilePath;
  final String name;
  final double popularity;

  const Person({
    required this.id,
    required this.profilePath,
    required this.name,
    required this.popularity,
  });
  @override
  List<Object?> get props => [id, profilePath, name, popularity];
}
