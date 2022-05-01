import 'package:equatable/equatable.dart';
import 'person.dart';

class PopularPersonResponse extends Equatable {
  final List<Person> personList;

  const PopularPersonResponse({required this.personList});
  @override
  List<Object?> get props => [personList];
}
