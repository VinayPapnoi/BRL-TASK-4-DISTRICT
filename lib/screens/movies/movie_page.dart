import 'package:flutter/material.dart';
import 'movie_detail_screen.dart';
import '../../widgets/movie_box.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({Key? key}) : super(key: key);

  final List<Map<String, String>> movies = const [
    {'title': 'Dune: Part Two', 'image': 'https://via.placeholder.com/200x300?text=Dune+2'},
    {'title': 'Joker: Folie à Deux', 'image': 'https://via.placeholder.com/200x300?text=Joker+2'},
    {'title': 'Deadpool & Wolverine', 'image': 'https://via.placeholder.com/200x300?text=Deadpool+3'},
    {'title': 'Inside Out 2', 'image': 'https://via.placeholder.com/200x300?text=Inside+Out+2'},
    {'title': 'Oppenheimer', 'image': 'https://via.placeholder.com/200x300?text=Oppenheimer'},
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 First Banner (In the Spotlight)
              _buildBannerImage('assets/images/spotlight_banner.png'),

              // 🔹 Spotlight Carousel
              _buildMovieCarousel(context),

              const SizedBox(height: 20),

              // 🔹 Second Banner
              _buildBannerImage('assets/images/below-spotlight.png'),

              const SizedBox(height: 20),

              // 🔹 Horizontal Scrollable Movie List (3 movies)
              _buildHorizontalMovieList(screenWidth),

              const SizedBox(height: 20),

              // 🔹 Explore Icon Banner
              _buildBannerImage('assets/images/explore_icon.png'),

              const SizedBox(height: 20),

              // 🔹 Two Side-by-Side Boxes
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildImageBox(context, 'assets/images/box_left.jpeg'),
                    _buildImageBox(context, 'assets/images/box_right.jpeg'),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔸 Helper - Common banner image widget (full visible, responsive)
  Widget _buildBannerImage(String path) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          path,
          fit: BoxFit.contain, // ✅ ensures full image is visible
          width: double.infinity,
        ),
      ),
    );
  }

  /// 🔸 Helper - Spotlight carousel
  Widget _buildMovieCarousel(BuildContext context) {
    final PageController controller = PageController(
      viewportFraction: 0.7,
      initialPage: 1000,
    );

    final List<Map<String, String>> movies = [
      {'title': 'Dune: Part Two', 'image': 'https://via.placeholder.com/200x300?text=Dune+2'},
      {'title': 'Joker', 'image': 'https://via.placeholder.com/200x300?text=Joker+2'},
      {'title': 'Deadpool & Wolverine', 'image': 'https://via.placeholder.com/200x300?text=Deadpool+3'},
      {'title': 'Inside Out 2', 'image': 'https://via.placeholder.com/200x300?text=Inside+Out+2'},
      {'title': 'Oppenheimer', 'image': 'https://via.placeholder.com/200x300?text=Oppenheimer'},
      {'title': 'Venom 3', 'image': 'https://via.placeholder.com/200x300?text=Venom+3'},
    ];

    final total = movies.length;

    return SizedBox(
      height: 280,
      child: PageView.builder(
        controller: controller,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final movie = movies[index % total];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailScreen(
                    title: movie['title']!,
                    image: movie['image']!,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(movie['image']!, fit: BoxFit.cover),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          movie['title']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// 🔸 Helper - Horizontal list (3 movies)
  Widget _buildHorizontalMovieList(double screenWidth) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 3,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemBuilder: (context, index) {
          return Container(
            width: screenWidth * 0.35,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    "https://via.placeholder.com/140x180?text=Movie+$index",
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Movie Title $index",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// 🔸 Helper - Two small side-by-side boxes
  Widget _buildImageBox(BuildContext context, String imagePath) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: (screenWidth - 48) / 2, // responsive width
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade800, width: 1.2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain, // ✅ no cropping here
          width: double.infinity,
        ),
      ),
    );
  }
}
