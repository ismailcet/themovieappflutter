import 'movie_model.dart';

class Response {
  final int? page;
  final int? totalPages;
  final int? totalResults;
  final List<Movie> results;

  Response(
      {required this.page,
      required this.totalPages,
      required this.totalResults,
      required this.results});

  factory Response.fromJson(Map<String, dynamic> json) {
    List<Movie> resultList = <Movie>[];
    if (json['results'] != null) {
      json['results'].forEach((v) {
        resultList.add(Movie.fromJson(v));
      });
    }
    return Response(
        page: json['page'],
        totalPages: json['total_pages'],
        totalResults: json['total_results'],
        results: resultList);
  }
}
