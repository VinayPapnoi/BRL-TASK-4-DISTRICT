import 'package:flutter/material.dart';
import '../movies/movie_data.dart';
import '../movies/movie_detail_screen.dart';
import '../events/event_data.dart';
import '../events/event_detail_screen.dart';
import '../dining/dining_data.dart';
import '../dining/dining_detail_screen.dart';
import '../../widgets/movie_box.dart';

class ForYouPage extends StatelessWidget {
  const ForYouPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            _buildBannerImage('assets/images/spotlight_banner.png'),
            const SizedBox(height: 20),

            _buildSpotlightCarousel(context),
            const SizedBox(height: 30),

            _buildBannerImage('assets/images/blockbuster.png'),
            const SizedBox(height: 20),

            _buildMovieCarousel(context),
            const SizedBox(height: 30),

            _buildBannerImage('assets/images/foodie.png'),
            const SizedBox(height: 20),

            _buildDiningCarousel(context),
            const SizedBox(height: 30),

            /// ✅ New Blockbuster Banner Before the Grid
            _buildBannerImage('assets/images/blockbuster.png'),
            const SizedBox(height: 20),

            /// ✅ Vertical Movie Grid (Two per row)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final boxWidth = (constraints.maxWidth - 12) / 2;
                  final gridCount = sampleMovies.length;
                  return Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: List.generate(gridCount, (index) {
                      final movie = sampleMovies[index];
                      return SizedBox(
                        width: boxWidth,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MovieDetailScreen(movieData: movie),
                              ),
                            );
                          },
                          child: MovieBox(
                            movieData: movie,
                            width: boxWidth,
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  /// Spotlight Carousel
  Widget _buildSpotlightCarousel(BuildContext context) {
    final controller = PageController(viewportFraction: 0.85, initialPage: 1000);
    final total = sampleEvents.length;

    return SizedBox(
      height: 450,
      child: PageView.builder(
        controller: controller,
        itemBuilder: (context, index) {
          final event = sampleEvents[index % total];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => EventDetailScreen(eventData: event)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(event['image']!, fit: BoxFit.cover),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 18,
                      left: 16,
                      child: Text(
                        event['title']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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

  /// Banner
  Widget _buildBannerImage(String path) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(path, fit: BoxFit.contain, width: double.infinity),
      ),
    );
  }

  /// Movie Carousel
  Widget _buildMovieCarousel(BuildContext context) {
    final controller = PageController(viewportFraction: 0.7);
    final total = sampleMovies.length;

    return SizedBox(
      height: 280,
      child: PageView.builder(
        controller: controller,
        itemBuilder: (context, index) {
          final movie = sampleMovies[index % total];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => MovieDetailScreen(movieData: movie)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(movie['bannerImage']!, fit: BoxFit.cover),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          movie['title']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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

  /// Dining Carousel
  Widget _buildDiningCarousel(BuildContext context) {
    final controller = PageController(viewportFraction: 0.75, initialPage: 1000);
    final total = sampleDining.length;

    return SizedBox(
      height: 320,
      child: PageView.builder(
        controller: controller,
        itemBuilder: (context, index) {
          final restaurant = sampleDining[index % total];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DiningDetailScreen(restaurantData: restaurant)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(restaurant['image']!, fit: BoxFit.cover),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black.withOpacity(0.85)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 18,
                      left: 16,
                      child: Text(
                        restaurant['name']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
