import 'package:flutter/foundation.dart';
import '../datas/models/app_models.dart';
import '../datas/models/app_models_impl.dart';
import '../datas/vos/genere_vo.dart';
import '../datas/vos/movie_vo.dart';
import '../datas/vos/person_vo.dart';

class HomeBloc extends ChangeNotifier {
  ///States
  List<MovieVO>? nowPlayingMovies;
  List<MovieVO>? popularMovies;
  List<GenereVO>? genereList;
  List<MovieVO>? moviesByGenere;
  List<MovieVO>? showCaseMovies;
  List<PersonVO>? popularActors;

  bool? errorFlag;
  String? errorMessage;

  ///Repository Dependency

  final AppModels _movieModel = AppModelsImpl();

  ///Constructor Method
  HomeBloc() {
    _getAllEndpointInstantAndSet();
  }

  ///GET MOVIES BY TAPPING GENERE
  onTapGenre({required int index}) async {
    moviesByGenere = null;
    notifyListeners();
    _movieModel
        .getMoviesByGenereFromDatabase(genereId: genereList![index].id!)
        ?.listen((data) {
      moviesByGenere = data;
      notifyListeners();
    }).onError((error, stackTrace) {
      errorFlag = true;
      errorMessage = error.toString();
      notifyListeners();
    });
  }

  ///RESET ERROR FLAG TO FALSE
  errorFlatReset() {
    errorFlag = false;
    errorMessage = '';
    notifyListeners();
  }

  ///GET ALL ENDPOINT INSTANT
  _getAllEndpointInstantAndSet() async {
    ///        NOW PLAYING MOVIES
    _movieModel.getNowPlayingFromDatabase()?.listen((movieList) {
      nowPlayingMovies = movieList;
      notifyListeners();
    }).onError((error, stackTrace) {
      errorFlag = true;
      errorMessage = error.toString();
      notifyListeners();
    });

    ///       POPULAR MOVIES
    _movieModel.getPopularMovieFromDatabase()?.listen((data) {
      popularMovies = data;
      notifyListeners();
    }).onError((error, stackTrace) {
      errorFlag = true;
      errorMessage = error.toString();
      notifyListeners();
    });

    ///        GENERE LIST
    _movieModel.getAllGenereFromDatabase()?.then((data) {
      genereList = data;
      notifyListeners();

      ///       MOVIES BY GENERE
      if (genereList!.isNotEmpty) {
        _movieModel
            .getMoviesByGenereFromDatabase(genereId: genereList![0].id!)
            ?.listen((data) {
          moviesByGenere = data;
          notifyListeners();
        }).onError((error, stackTrace) {
          errorFlag = true;
          errorMessage = error.toString();
          notifyListeners();
        });
      }
    }).onError((error, stackTrace) {
      errorFlag = true;
      errorMessage = error.toString();
      notifyListeners();
    });

    ///       SHOWCASE MOVIES
    _movieModel.getShowCaseMoviesFromDatabase()?.listen((data) {
      showCaseMovies = data;
      notifyListeners();
    }).onError((error, stackTrace) {
      errorFlag = true;
      errorMessage = error.toString();
      notifyListeners();
    });

    ///      POPULAR ACTORS
    _movieModel.getPopularPersonFromDatabase()?.then((data) {
      popularActors = data;
      notifyListeners();
    }).onError((error, stackTrace) {
      errorFlag = true;
      errorMessage = error.toString();
      notifyListeners();
    });
  }
}
