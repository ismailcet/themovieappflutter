import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:themovieapp/models/movie_detail_model.dart';

class MovieDetailRepository {
  Future<MovieDetail> fetchMovieDetailById(int id) async {
    String url = "https://api.themoviedb.org/3/movie/${id}?language=en-US";
    Map<String, String> requestHeaders = {
      "Content-type": "application/json",
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNzk4MDI4ZDNkYjU0YWI3OTg3ZmE1ZmRhMTk3OTE5MiIsIm5iZiI6MTY0NDA5NTAyMC4xOTkwMDAxLCJzdWIiOiI2MWZlZTYyYzlmNWRmYjAwOGYwOGYwZTYiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.zYdZEzvRDw4D4G4Jp6JGJdXhyP0efXCYWlVg6KAAWGE"
    };
    final response = await http.get(Uri.parse(url), headers: requestHeaders);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return MovieDetail.fromJson(body);
    }
    throw Exception("Servis çağrımı sırasında bir hata oluştur !");
  }
}
