import 'package:themovieapp/models/movie_detail_model.dart';
import 'package:themovieapp/repository/movie_detail_repository.dart';
import 'package:themovieapp/repository/movie_repository.dart';

import '../models/response_model.dart';

class MovieService {
  final _rep = MovieRepository();
  final _movDetailRep = MovieDetailRepository();

  Future<Response> fetchAllMovies() async {
    final response = await _rep.fetchAllMovie();
    return response;
  }

  Future<Response> fetchMovieAccordingFilter(String filter) async {
    final response = await _rep.fetchMovieAccordingFilter(filter);
    return response;
  }

  Future<MovieDetail> fetchMovieDetail(int id) async {
    final response = await _movDetailRep.fetchMovieDetailById(id);
    return response;
  }
}
