import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:themovieapp/models/movie_detail_model.dart';
import 'package:themovieapp/provider/watchlist_provider.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Watch list",
            style: GoogleFonts.montserrat(
                fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
        body: context.read<WatchlistProvider>().watchList.isEmpty
            ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/box_image.png',
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      width: 76,
                      height: 76,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "There is no movie yet!",
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Find your movie by Type title, \ncategories, years, etc ",
                      style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff92929D)),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.only(top: 24),
                itemCount: context.read<WatchlistProvider>().watchList.length,
                itemBuilder: (context, index) {
                  MovieDetail m =
                      context.read<WatchlistProvider>().watchList[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 36,
                      top: 24,
                      right: 36,
                    ),
                    child: Center(
                      child: SizedBox(
                        width: width * .9,
                        height: height * .15,
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: CachedNetworkImage(
                                  imageUrl:
                                      "https://image.tmdb.org/t/p/w500${m.posterPath}" ??
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
                                      )),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  m.title ?? "NULL",
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 14.0),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.star_border_outlined,
                                          color: Color(0xFFFF8700),
                                          size: 16,
                                        ),
                                        Text(
                                          "${m.voteAverage?.toStringAsFixed(1)}",
                                          style: const TextStyle(
                                            color: Color(0xFFFF8700),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.local_activity,
                                        size: 16, color: Color(0xFF92929D)),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      m.genres?.first.name.toString() ??
                                          'Action',
                                      style: const TextStyle(
                                          color: Color(0xFF92929D),
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today,
                                        size: 16, color: Color(0xFF92929D)),
                                    const SizedBox(width: 4),
                                    Text(
                                      DateTime.parse(
                                                  m.releaseDate ?? "2024-01-01")
                                              .year
                                              .toString() ??
                                          '2024',
                                      style: const TextStyle(
                                          color: Color(0xFF92929D),
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time,
                                        size: 16, color: Color(0xFF92929D)),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${m.runtime} Minutes',
                                      style: const TextStyle(
                                          color: Color(0xFF92929D),
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }));
  }
}
