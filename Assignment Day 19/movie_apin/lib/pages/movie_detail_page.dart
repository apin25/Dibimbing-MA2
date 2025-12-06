import 'package:flutter/material.dart';
import 'package:movie_apin/data/movie_detail_response.dart';
import 'package:movie_apin/data/movie_service.dart';
import 'package:movie_apin/data/state/remote_state.dart';
class MovieDetailPage extends StatefulWidget {
  final int id;

  const MovieDetailPage({super.key, required this.id});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final MovieService _movieService = MovieService();
  MovieDetailResponse? movieDetail;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadMovieDetail();
  }

  Future<void> _loadMovieDetail() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final state = await _movieService.fetchMovieDetail(widget.id);

      if (state is RemoteStateSuccess<MovieDetailResponse>) {
        setState(() {
          movieDetail = state.data;
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = "Failed to load movie details";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: const Color(0xFF1A1A2E),
        body: const Center(
          child: CircularProgressIndicator(color: Colors.blue),
        ),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        backgroundColor: const Color(0xFF1A1A2E),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 60),
              const SizedBox(height: 16),
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadMovieDetail,
                child: const Text('Retry'),
              )
            ],
          ),
        ),
      );
    }

    final movie = movieDetail!;

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 450,
            pinned: true,
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    "https://image.tmdb.org/t/p/original${movie.backdropPath ?? movie.posterPath}",
                    fit: BoxFit.cover,
                  ),

                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Color(0xFF1A1A2E),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Text(
                      movie.title ?? "No Title",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins"
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.overview ?? "No overview available",
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.5,
                      fontFamily: "Poppins"
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    "Genres",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins"
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: movie.genres
                        .map((g) => Chip(
                              label: Text(
                                g.name ?? "",
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.blue.withValues(alpha:0.2),
                              side: BorderSide.none,
                            ))
                        .toList(),
                  ),

                  const SizedBox(height: 20),

                  Divider(color: Colors.white24),

                  const SizedBox(height: 16),

                  _buildInfo("Release Date", movie.releaseDate ?? "-"),
                  _buildInfo("Status", movie.status ?? "-"),
                  _buildInfo("Runtime", "${movie.runtime ?? 0} minutes"),
                  _buildInfo("Rating", "${movie.voteAverage?.toStringAsFixed(1) ?? "-"} ⭐"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white54,
                fontFamily: "Poppins"
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: "Poppins"
              ),
            ),
          ),
        ],
      ),
    );
  }
}
