import 'dart:convert';

import 'package:themovieapp/models/response_model.dart';
import 'package:http/http.dart' as http;

class MovieRepository {
  Future<Response> fetchAllMovie() async {
    String url =
        "https://api.themoviedb.org/3/trending/movie/day?language=en-US&page=1";
    Map<String, String> requestHeaders = {
      "Content-type": "application/json",
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNzk4MDI4ZDNkYjU0YWI3OTg3ZmE1ZmRhMTk3OTE5MiIsIm5iZiI6MTY0NDA5NTAyMC4xOTkwMDAxLCJzdWIiOiI2MWZlZTYyYzlmNWRmYjAwOGYwOGYwZTYiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.zYdZEzvRDw4D4G4Jp6JGJdXhyP0efXCYWlVg6KAAWGE"
    };

    final response = await http.get(Uri.parse(url), headers: requestHeaders);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return Response.fromJson(body);
    }
    throw Exception('Çağırım sırasında bir hata oluştu');
  }

  Future<Response> fetchMovieAccordingFilter(String filter) async {
    String url =
        "https://api.themoviedb.org/3/movie/${filter}?language=en-US&page=1";
    Map<String, String> requestHeaders = {
      "Content-type": "application/json",
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNzk4MDI4ZDNkYjU0YWI3OTg3ZmE1ZmRhMTk3OTE5MiIsIm5iZiI6MTY0NDA5NTAyMC4xOTkwMDAxLCJzdWIiOiI2MWZlZTYyYzlmNWRmYjAwOGYwOGYwZTYiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.zYdZEzvRDw4D4G4Jp6JGJdXhyP0efXCYWlVg6KAAWGE"
    };
    final response = await http.get(Uri.parse(url), headers: requestHeaders);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return Response.fromJson(body);
    }
    throw Exception('Çağrım sırasında bir hata oluştu');
  }
}
