import 'package:equatable/equatable.dart';
import 'person.dart';

class ActorsCrewsResponse extends Equatable {
  final List<Person> actors;
  final List<Person> crews;

  const ActorsCrewsResponse({
    required this.actors,
    required this.crews,
  });
  @override
  List<Object?> get props => [actors, crews];
}
