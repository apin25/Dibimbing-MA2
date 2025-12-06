import 'package:flutter/material.dart';
import 'package:movie_apin/data/movie_list_response.dart';
import 'package:movie_apin/data/movie_service.dart';
import 'package:movie_apin/data/state/remote_state.dart';
import 'package:movie_apin/models/movie_model.dart';

class ListMoviesPage extends StatefulWidget {
  const ListMoviesPage({super.key});

  @override
  State<ListMoviesPage> createState() => _ListMoviesPageState();
}

class _ListMoviesPageState extends State<ListMoviesPage> {
  String selectedCategory = 'All';
  final List<String> categories = ['All', 'Action', 'Comedy', 'Romance', 'Horror'];
  final Map<String, int> genreMap = {
  'Action': 28,
  'Comedy': 35,
  'Romance': 10749,
  'Horror': 27,
};

  List<MovieModel> popularMovies = [];
  List<MovieModel> latestMovies = [];
  MovieModel? featuredMovie;
  bool isLoading = true;
  String? errorMessage;

  final MovieService _movieService = MovieService();

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // Fetch popular movies using your service
      final popularState = await _movieService.fetchPopularMovies();

      if (popularState is RemoteStateSuccess<MovieListResponse>) {
        final popularData = popularState.data;
        
        setState(() {
          popularMovies = popularData.results;
          latestMovies = popularData.results; 
          featuredMovie = popularMovies.isNotEmpty ? popularMovies[0] : null;
          isLoading = false;
        });
      } else if (popularState is RemoteStateError) {
        setState(() {
          isLoading = false;
          errorMessage = popularState.toString();
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load movies: $e';
      });
      errorMessage = ('Error loading movies: $e');
    }
  }

 Future<void> _loadMoviesByCategory(String category) async {
  setState(() {
    isLoading = true;
    errorMessage = null;
  });

  if (category == 'All') {
    _loadMovies();
    return;
  }

  final genreId = genreMap[category];
  if (genreId == null) return;

  final state = await _movieService.fetchMoviesByGenre(genreId);

  if (state is RemoteStateSuccess<MovieListResponse>) {
    setState(() {
      popularMovies = state.data.results;
      latestMovies = state.data.results;
      featuredMovie = popularMovies.isNotEmpty ? popularMovies[0] : null;
      isLoading = false;
    });
  } else if (state is RemoteStateError) {
    setState(() {
      errorMessage = errorMessage;
      isLoading = false;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
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
              : CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        height: 400,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.grey.shade800,
                              const Color(0xFF1A1A2E),
                            ],
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      featuredMovie?.backdropPath != null
                                          ? 'https://image.tmdb.org/t/p/original${featuredMovie!.backdropPath}'
                                          : 'https://image.tmdb.org/t/p/original/7WsyChQLEftFiDOVTGkv3hFZbM9.jpg',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                foregroundDecoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      const Color(0xFF1A1A2E).withValues(alpha:0.9),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Content
                            Positioned(
                              bottom: 60,
                              left: 0,
                              right: 0,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Text(
                                      featuredMovie?.title.toUpperCase() ?? 'FEATURED MOVIE',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 4,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  if (featuredMovie?.releaseDate != null && 
                                      featuredMovie!.releaseDate!.isNotEmpty &&
                                      featuredMovie!.releaseDate!.length >= 4)
                                    Text(
                                      featuredMovie!.releaseDate!.substring(0, 4),
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        featuredMovie?.voteAverage.toStringAsFixed(1) ?? '0.0',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      3,
                                      (index) => Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 4),
                                        width: index == 1 ? 24 : 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: index == 1 ? Colors.blue : Colors.white30,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Categories Section
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Categories',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: 40,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: categories.length,
                                itemBuilder: (context, index) {
                                  final category = categories[index];
                                  final isSelected = category == selectedCategory;
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedCategory = category;
                                      });
                                      _loadMoviesByCategory(category);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 12),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Colors.blue
                                            : Colors.white.withValues(alpha:0.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: Text(
                                          category,
                                          style: TextStyle(
                                            color: isSelected ? Colors.white : Colors.white70,
                                            fontWeight: isSelected
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Most Popular Section
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Most Popular',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  '/category',
                                  arguments: {
                                    'genreId': genreMap[selectedCategory]
                                  },
                                );
                              },
                              child: const Text(
                                'See all',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 220,
                        child: popularMovies.isEmpty
                            ? const Center(
                                child: Text(
                                  'No movies found',
                                  style: TextStyle(color: Colors.white70),
                                ),
                              )
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                itemCount: popularMovies.length,
                                itemBuilder: (context, index) {
                                  final movie = popularMovies[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/detail',
                                        arguments: {
                                          'id': movie.id,
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: 140,
                                      margin: const EdgeInsets.only(right: 12),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(12),
                                              child: movie.posterPath != null
                                                  ? Image.network(
                                                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                      fit: BoxFit.cover,
                                                      width: double.infinity,
                                                      errorBuilder: (context, error, stackTrace) {
                                                        return Container(
                                                          color: Colors.grey.shade800,
                                                          child: const Icon(
                                                            Icons.movie,
                                                            color: Colors.white30,
                                                            size: 50,
                                                          ),
                                                        );
                                                      },
                                                    )
                                                  : Container(
                                                      color: Colors.grey.shade800,
                                                      child: const Icon(
                                                        Icons.movie,
                                                        color: Colors.white30,
                                                        size: 50,
                                                      ),
                                                    ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
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
                                          
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ),

                    // Latest Movies Section
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Latest Movies',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/category',
                              arguments: {
                                'genreId': genreMap[selectedCategory]
                              },
                            );
                          },
                              child: const Text(
                                'See all',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 220,
                        child: latestMovies.isEmpty
                            ? const Center(
                                child: Text(
                                  'No movies found',
                                  style: TextStyle(color: Colors.white70),
                                ),
                              )
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                itemCount: latestMovies.length,
                                itemBuilder: (context, index) {
                                  final movie = latestMovies[index];
                                  return GestureDetector(
                                    onTap: () {
                                      // Navigate to movie detail using movie.id
                                      // You can fetch details using _movieService.fetchMovieDetail(movie.id)
                                    },
                                    child: Container(
                                      width: 140,
                                      margin: const EdgeInsets.only(right: 12),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(12),
                                              child: movie.posterPath != null
                                                  ? Image.network(
                                                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                      fit: BoxFit.cover,
                                                      width: double.infinity,
                                                      errorBuilder: (context, error, stackTrace) {
                                                        return Container(
                                                          color: Colors.grey.shade800,
                                                          child: const Icon(
                                                            Icons.movie,
                                                            color: Colors.white30,
                                                            size: 50,
                                                          ),
                                                        );
                                                      },
                                                    )
                                                  : Container(
                                                      color: Colors.grey.shade800,
                                                      child: const Icon(
                                                        Icons.movie,
                                                        color: Colors.white30,
                                                        size: 50,
                                                      ),
                                                    ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
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
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ),

                    const SliverToBoxAdapter(
                      child: SizedBox(height: 20),
                    ),
                  ],
                ),
    );
  }
}