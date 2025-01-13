import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:themovieapp/enums/filter_enum.dart';
import 'package:themovieapp/models/response_model.dart';
import 'package:themovieapp/pages/movie_detail_page.dart';
import 'package:themovieapp/services/movie_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _service = MovieService();

  String filter = FilterList.popular.value;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
        child: Column(
          children: [
            Text(
              "What do you want to watch?",
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w900),
              textAlign: TextAlign.end,
            ),
            const SizedBox(
              height: 24,
            ),
            TextField(
              decoration: InputDecoration(
                focusColor: const Color(0xFF3A3F47),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                fillColor: const Color(0xFF3A3F47),
                filled: true,
                contentPadding: const EdgeInsets.only(
                    left: 24, right: 18, top: 10, bottom: 10),
                hintText: "Search",
                hintStyle: GoogleFonts.poppins(
                    color: const Color(0xFF67686D),
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
                suffixIcon: const Icon(Icons.search, color: Color(0xFF67686D)),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
                height: height * .274,
                width: width,
                child: FutureBuilder<Response>(
                    future: _service.fetchAllMovies(),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: SpinKitCircle(
                            size: 50,
                            color: Colors.blue,
                          ),
                        );
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data?.results.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final number = index + 1;
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MovieDetailPage(
                                              movieId: snapshot.data!
                                                      .results[index].id ??
                                                  1010581)));
                                },
                                child: SizedBox(
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Container(
                                        width: 200,
                                        height: 240,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: height * .02),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "https://image.tmdb.org/t/p/w500${snapshot.data!.results[index].posterPath}" ??
                                                    '',
                                            fit: BoxFit.cover,
                                            placeholder: (BuildContext context,
                                                String url) {
                                              return const SizedBox(
                                                child: SpinKitFadingCircle(
                                                  color: Colors.amber,
                                                  size: 50,
                                                ),
                                              );
                                            },
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(
                                              Icons.error_outline,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: height * .169,
                                        left: width * .001,
                                        child: Center(
                                          child: Stack(
                                            children: [
                                              Text(
                                                number.toString() ?? "0",
                                                style: TextStyle(
                                                  fontSize:
                                                      90, // Yazının boyutu
                                                  //color: Color(
                                                  //  0xFF242A32), // Yazının rengi
                                                  fontWeight: FontWeight
                                                      .bold, // Yazının kalınlığı
                                                  foreground: Paint()
                                                    ..style = PaintingStyle
                                                        .stroke // Çizgi boyama stili
                                                    ..strokeWidth =
                                                        1 // Çizgi kalınlığı
                                                    ..color = const Color(
                                                        0xFF0296E5), // Çizgi rengi
                                                  // İsteğe bağlı olarak yazının içini boyamak için bir gölgeyle ikinci Text ekleyebilirsiniz
                                                ),
                                              ),
                                              Text(
                                                number.toString() ?? "0",
                                                style: const TextStyle(
                                                  fontSize: 90, // Yazı boyutu
                                                  fontWeight: FontWeight
                                                      .bold, // Kalınlık
                                                  color: Color(
                                                      0xFF242A32), // İç dolgu rengi
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    })),
            const SizedBox(
              height: 24,
            ),
            Column(
              children: [
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: FilterList.values.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            filter = FilterList.values[index].value;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    FilterList.values[index].name.toString(),
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight:
                                            FilterList.values[index].value ==
                                                    filter
                                                ? FontWeight.bold
                                                : FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 4,
                                    width: 60, // Çizgi genişliği
                                    color:
                                        filter == FilterList.values[index].value
                                            ? const Color(0xFF3A3F47)
                                            : Colors.transparent,
                                  ),
                                ]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: height * .292,
                  child: FutureBuilder(
                      future: _service.fetchMovieAccordingFilter(filter),
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: SpinKitCircle(
                              size: 50,
                              color: Colors.blue,
                            ),
                          );
                        } else {
                          return Center(
                            child: GridView.builder(
                                itemCount: snapshot.data?.results.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 12,
                                        mainAxisSpacing: 16,
                                        childAspectRatio: .69),
                                itemBuilder: (BuildContext context, i) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MovieDetailPage(
                                                      movieId: snapshot.data!
                                                              .results[i].id ??
                                                          1010581)));
                                    },
                                    child: SizedBox(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "https://image.tmdb.org/t/p/w500${snapshot.data!.results[i].posterPath}" ??
                                                  '',
                                          fit: BoxFit.cover,
                                          placeholder: (BuildContext context,
                                              String url) {
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
                                  );
                                }),
                          );
                        }
                      }),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
