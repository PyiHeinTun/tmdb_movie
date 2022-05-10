import '../../datas/vos/person_vo.dart';

abstract class PersonDaos {
  void writePersonDaos({required List<PersonVO>? personList});

  List<PersonVO> getPopularPerson();
  List<PersonVO> getActors();
  List<PersonVO> getCrews();
}
