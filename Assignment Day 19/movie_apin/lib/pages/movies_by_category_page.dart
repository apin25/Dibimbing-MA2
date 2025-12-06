import 'package:flutter/material.dart';
import 'package:movie_apin/data/movie_list_response.dart';
import 'package:movie_apin/data/movie_service.dart';
import 'package:movie_apin/data/state/remote_state.dart';
import 'package:movie_apin/models/movie_model.dart';
import 'package:movie_apin/pages/movie_detail_page.dart';

class MovieCategoryPage extends StatefulWidget {
  final int? genreId;

  const MovieCategoryPage({
    super.key,
    this.genreId,
  });

  @override
  State<MovieCategoryPage> createState() => _MovieCategoryPageState();
}

class _MovieCategoryPageState extends State<MovieCategoryPage> {
  final MovieService _movieService = MovieService();
  List<MovieModel> movies = [];
  bool isLoading = true;
  bool isLoadingMore = false;
  String? errorMessage;
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;
  int totalPages = 1;
  
  final genreNames = {
    28: "Action",
    35: "Comedy",
    10749: "Romance",
    27: "Horror",
  };

  @override
  void initState() {
    super.initState();
    _loadMovies();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        _loadMoreMovies();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadMovies() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
      currentPage = 1;
    });

    try {
      RemoteState state;

      if (widget.genreId == null) {
        state = await _movieService.fetchPopularMovies(page: currentPage);
      } else {
        state = await _movieService.fetchMoviesByGenre(widget.genreId!, page: currentPage);
      }

      if (state is RemoteStateSuccess<MovieListResponse>) {
        final success = state as RemoteStateSuccess<MovieListResponse>;

        setState(() {
          movies = success.data.results;
          totalPages = success.data.totalPages ?? 1;
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = "Failed to load movies";
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

  Future<void> _loadMoreMovies() async {
    // Jangan load jika sedang loading atau sudah mencapai halaman terakhir
    if (isLoadingMore || currentPage >= totalPages) return;

    setState(() {
      isLoadingMore = true;
    });

    try {
      final nextPage = currentPage + 1;
      RemoteState state;

      if (widget.genreId == null) {
        state = await _movieService.fetchPopularMovies(page: nextPage);
      } else {
        state = await _movieService.fetchMoviesByGenre(widget.genreId!, page: nextPage);
      }

      if (state is RemoteStateSuccess<MovieListResponse>) {
        final success = state as RemoteStateSuccess<MovieListResponse>;

        setState(() {
          movies.addAll(success.data.results);
          currentPage = nextPage;
          totalPages = success.data.totalPages ?? totalPages;
          isLoadingMore = false;
        });
      } else {
        setState(() {
          isLoadingMore = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          genreNames[widget.genreId] ?? "Movies",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          errorMessage!,
                          style: const TextStyle(color: Colors.white70),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadMovies,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : movies.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.movie_filter_outlined,
                            color: Colors.white30,
                            size: 80,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No movies found',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        // Movie count info
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Text(
                                '${movies.length} Movies',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                'Page $currentPage of $totalPages',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Movie grid
                        Expanded(
                          child: GridView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 0,
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 20,
                              childAspectRatio: 0.65,
                            ),
                            itemCount: movies.length + (isLoadingMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == movies.length) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: CircularProgressIndicator(
                                      color: Colors.blue,
                                    ),
                                  ),
                                );
                              }
                              final movie = movies[index];
                              return _buildMovieCard(movie);
                            },
                          ),
                        ),
                      ],
                    ),
    );
  }

  Widget _buildMovieCard(MovieModel movie) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/detail',
          arguments: { 'id': movie.id },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie poster
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    // Poster image
                    movie.posterPath != null
                        ? Image.network(
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey.shade800,
                                child: const Center(
                                  child: Icon(
                                    Icons.movie,
                                    color: Colors.white30,
                                    size: 50,
                                  ),
                                ),
                              );
                            },
                          )
                        : Container(
                            color: Colors.grey.shade800,
                            child: const Center(
                              child: Icon(
                                Icons.movie,
                                color: Colors.white30,
                                size: 50,
                              ),
                            ),
                          ),
                    // Rating badge
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha:0.7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              movie.voteAverage.toStringAsFixed(1),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Movie title
            Text(
              movie.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            // Release year
            if (movie.releaseDate != null &&
                movie.releaseDate!.isNotEmpty &&
                movie.releaseDate!.length >= 4)
              Text(
                movie.releaseDate!.substring(0, 4),
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 12,
                ),
              ),
          ],
        ),
      ),
    );
  }
}