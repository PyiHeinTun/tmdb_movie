import '../../../datas/vos/person_vo.dart';
import '../person_daos.dart';
import '../../hive_constants.dart';
import 'package:hive/hive.dart';

class PersonDaosImpl implements PersonDaos {
  static final PersonDaosImpl _singleton = PersonDaosImpl._internal();

  factory PersonDaosImpl() => _singleton;

  PersonDaosImpl._internal();

  @override
  List<PersonVO> getPopularPerson() {
    return openBox()
        .values
        .where((element) => element.popularActors == true)
        .toList();
  }

  @override
  List<PersonVO> getActors() {
    return openBox().values.where((element) => element.cast == true).toList();
  }

  @override
  List<PersonVO> getCrews() {
    return openBox().values.where((element) => element.crew == true).toList();
  }

  @override
  Future<void> writePersonDaos({required List<PersonVO>? personList}) async {
    await openBox().putAll(
        personList!.asMap().map((key, person) => MapEntry(person.id, person)));
  }

  Box<PersonVO> openBox() {
    return Hive.box(kHiveBoxPerson);
  }
}
