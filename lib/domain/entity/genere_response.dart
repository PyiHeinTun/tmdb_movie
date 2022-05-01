import 'package:equatable/equatable.dart';
import 'genere.dart';

class GenereResponse extends Equatable {
  final List<Genere> genereList;
  const GenereResponse({required this.genereList});
  @override
  List<Object?> get props => [genereList];
}
