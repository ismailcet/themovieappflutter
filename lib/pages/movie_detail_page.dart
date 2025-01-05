import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:themovieapp/models/movie_detail_model.dart';
import 'package:themovieapp/services/movie_service.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;
  const MovieDetailPage({required this.movieId, Key? key}) : super(key: key);

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final _service = MovieService();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail",
          style: GoogleFonts.montserrat(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        child: FutureBuilder<MovieDetail>(
          future: _service.fetchMovieDetail(widget.movieId),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SpinKitCircle(
                  size: 50,
                  color: Colors.blue,
                ),
              );
            } else {
              DateTime date =
                  DateTime.parse(snapshot.data?.releaseDate ?? "2024-01-01");
              return Column(
                children: [
                  SizedBox(
                    height: height * .35,
                    child: Stack(
                      children: [
                        SizedBox(
                          height: height * .25,
                          width: width,
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://image.tmdb.org/t/p/w500${snapshot.data!.backdropPath}" ??
                                    '',
                            fit: BoxFit.fitWidth,
                            placeholder: (BuildContext context, String url) {
                              return const SizedBox(
                                child: SpinKitFadingCircle(
                                  color: Colors.amber,
                                  size: 50,
                                ),
                              );
                            },
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 120,
                          right: 5,
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 8, top: 4, right: 8, bottom: 4),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor, // Arka plan rengi
                              borderRadius: BorderRadius.circular(
                                  15), // Yuvarlatılmış köşeler
                            ),
                            width: 80,
                            child: Center(
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star_border_outlined,
                                    color: Color(0xFFFF8700),
                                    size: 24,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "${snapshot.data?.voteAverage?.toStringAsFixed(1)}",
                                    style: const TextStyle(
                                      color: Color(0xFFFF8700),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Positioned(
                          top: 120,
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 160,
                                  width: 105,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "https://image.tmdb.org/t/p/w500${snapshot.data!.posterPath}" ??
                                              '',
                                      fit: BoxFit.cover,
                                      placeholder:
                                          (BuildContext context, String url) {
                                        return const SizedBox(
                                          child: SpinKitFadingCircle(
                                            color: Colors.amber,
                                            size: 50,
                                          ),
                                        );
                                      },
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 100.0, left: 12),
                                  child: Text(
                                    snapshot.data?.title ?? "Name",
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                    softWrap: true,
                                    style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Date
                          Row(
                            children: [
                              const Icon(Icons.calendar_today,
                                  size: 18, color: Color(0xFF92929D)),
                              const SizedBox(width: 4),
                              Text(
                                date.year.toString() ?? '2024',
                                style: const TextStyle(
                                    color: Color(0xFF92929D), fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(width: 16), // Spacer between items

                          // Duration
                          Row(
                            children: [
                              const Icon(Icons.access_time,
                                  size: 18, color: Color(0xFF92929D)),
                              const SizedBox(width: 4),
                              Text(
                                '${snapshot.data?.runtime} Minutes',
                                style: const TextStyle(
                                    color: Color(0xFF92929D), fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(width: 16), // Spacer between items

                          // Genre
                          Row(
                            children: [
                              const Icon(Icons.local_activity,
                                  size: 18, color: Color(0xFF92929D)),
                              const SizedBox(width: 4),
                              Text(
                                snapshot.data?.genres?.first.name.toString() ??
                                    'Action',
                                style: const TextStyle(
                                    color: Color(0xFF92929D), fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(29.0),
                      child: Text(
                        snapshot.data?.overview ?? "Null",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
