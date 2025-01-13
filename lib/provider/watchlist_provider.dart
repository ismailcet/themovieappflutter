import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:themovieapp/models/movie_detail_model.dart';
import 'package:themovieapp/models/movie_model.dart';

class WatchlistProvider extends ChangeNotifier {
  List<MovieDetail> _watchList = [];
  List<MovieDetail> get watchList => _watchList;

  void addWatchList(MovieDetail? movie) {
    if (controlIfMovieInList(movie)) {
      deleteWatchListToItem(movie);
    } else {
      if (movie != null) {
        _watchList.add(movie);
        notifyListeners();
      }
    }
  }

  void deleteWatchListToItem(MovieDetail? movie) {
    _watchList.removeWhere((i) => i.id == movie?.id);
    notifyListeners();
  }

  bool controlIfMovieInList(MovieDetail? movie) {
    if (_watchList.where((i) => i.id == movie?.id).isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
