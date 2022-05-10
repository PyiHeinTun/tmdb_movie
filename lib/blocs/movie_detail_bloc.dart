import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../datas/models/app_models.dart';
import '../datas/models/app_models_impl.dart';
import '../datas/vos/person_vo.dart';

import '../datas/vos/movie_vo.dart';

class MovieDetailBloc extends ChangeNotifier {
  ///MovieID for Detail
  final String movieId;
  late StreamSubscription<MovieVO?>? subscription;

  ///States
  MovieVO? movieDetail;
  List<PersonVO>? actors;
  List<PersonVO>? crews;

  bool? errorFlag;
  String? errorMessage;

  ///Repository Dependency
  final AppModels reposistory = AppModelsImpl();

  ///Constructor Method
  MovieDetailBloc({required this.movieId}) {
    getAllEndPointInstantAndSet();
  }

  ///RESET ERROR FLAG TO FALSE
  errorFlatReset() {
    errorFlag = false;
    errorMessage = '';
    notifyListeners();
  }

  getAllEndPointInstantAndSet() async {
    //
    /// MOVIE DETAIL BY ID
    var _notNotifyDetailBloc = false;
    subscription = reposistory
        .getMovieDetailByIdFromDatabase(movieId: movieId)
        ?.listen((event) {
      if (event?.generes != null && !_notNotifyDetailBloc) {
        movieDetail = event;
        _notNotifyDetailBloc = true;
        notifyListeners();
      }
    });

    //
    /// GET ACTORS
    reposistory.getActors(movieId: movieId)?.then((data) {
      actors = data;
      notifyListeners();
    }).onError((error, stackTrace) {
      errorFlag = true;
      errorMessage = error.toString();
      notifyListeners();
    });

    //
    /// GET CREWS
    reposistory.getCrews(movieId: movieId)?.then((data) {
      crews = data;
      notifyListeners();
    }).onError((error, stackTrace) {
      errorFlag = true;
      errorMessage = error.toString();
    });
  }
}
