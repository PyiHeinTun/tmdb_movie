import '../../datas/vos/genere_vo.dart';

abstract class GenereDaos {
  void writeAllGenereDaos({required List<GenereVO> genereList});

  List<GenereVO>? readAllGenereDaos();
}
