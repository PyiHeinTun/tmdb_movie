import '../../../datas/vos/genere_vo.dart';
import '../genere_daos.dart';
import '../../hive_constants.dart';
import 'package:hive/hive.dart';

class GenereDaosImpl implements GenereDaos {
  static final GenereDaosImpl _singleton = GenereDaosImpl._internal();
  Box? box;

  factory GenereDaosImpl() {
    return _singleton;
  }

  GenereDaosImpl._internal();

  @override
  List<GenereVO>? readAllGenereDaos() {
    return openBox().values.toList();
  }

  @override
  void writeAllGenereDaos({required List<GenereVO>? genereList}) async {
    openBox().putAll(
        genereList?.asMap().map((key, genere) => MapEntry(genere.id, genere)) ??
            {});
  }

  Box<GenereVO> openBox() {
    return Hive.box(kHiveBoxGenere);
  }
}
