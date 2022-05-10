import '../datas/vos/genere_vo.dart';
import '../datas/vos/movie_vo.dart';
import '../datas/vos/person_vo.dart';
import '../datas/vos/production_country_vo.dart';
import 'hive_constants.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveHelper {
  static Future<void> init() async {
    final _tempDirectory = await getApplicationDocumentsDirectory();
    Hive.init(_tempDirectory.path);
  }

  static Future<void> registerAdapter() async {
    Hive.registerAdapter(GenereVoAdapter());
    Hive.registerAdapter(MovieVoAdapter());
    Hive.registerAdapter(PersonVoAdapter());
    Hive.registerAdapter(ProductionCountryVoAdapter());
  }

  static Future<void> openBoxs() async {
    await Hive.openBox<GenereVO>(kHiveBoxGenere);
    await Hive.openBox<MovieVO>(kHiveBoxMovie);
    await Hive.openBox<PersonVO>(kHiveBoxPerson);
  }
}
