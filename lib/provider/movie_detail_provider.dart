import 'package:flutter/foundation.dart';
import 'package:themovieapp/models/movie_detail_model.dart';

import '../services/movie_service.dart';

class MovieDetailProvider extends ChangeNotifier {
  final int movieId;
  MovieDetail? movieDetail;
  final _service = MovieService();

  MovieDetailProvider(this.movieId) {
    _fetchMovieDetail();
  }

  Future<void> _fetchMovieDetail() async {
    try {
      final movie = await MovieService().fetchMovieDetail(movieId);
      movieDetail = movie;
    } catch (error) {
      print('Failed to load movie details');
    } finally {
      notifyListeners();
    }
  }
}
