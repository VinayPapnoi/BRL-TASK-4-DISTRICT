import 'package:flutter/material.dart';
import '../movies/movie_data.dart';
import '../movies/movie_detail_screen.dart';
import '../events/event_data.dart';
import '../events/event_detail_screen.dart';
import '../dining/dining_data.dart';
import '../dining/dining_detail_screen.dart';

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

            // Main Spotlight Carousel
            _buildSpotlightCarousel(context, screenWidth),

            const SizedBox(height: 30),

            // Blockbuster Banner
            _buildBannerImage('assets/images/blockbuster.png'),

            const SizedBox(height: 20),

            // Movie Carousel
            _buildMovieCarousel(context),

            const SizedBox(height: 20),

            _buildBannerImage('assets/images/foodie.png'),

            const SizedBox(height: 20),

            // Dining Carousel
            _buildDiningCarousel(context),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  /// Main Spotlight Carousel (Full-width cards)
  Widget _buildSpotlightCarousel(BuildContext context, double screenWidth) {
    final PageController controller = PageController(
      viewportFraction: 0.85,
      initialPage: 1000,
    );

    final total = sampleEvents.length;

    return SizedBox(
      height: 450,
      child: PageView.builder(
        controller: controller,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final event = sampleEvents[index % total];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventDetailScreen(eventData: event),
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
                    // Background Image (Local Asset)
                    Image.asset(
                      event['image']!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[800],
                        child: const Icon(
                          Icons.broken_image,
                          color: Colors.white54,
                          size: 50,
                        ),
                      ),
                    ),

                    // Gradient Overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.5),
                            Colors.black.withOpacity(0.9),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.3, 0.6, 1.0],
                        ),
                      ),
                    ),

                    // Bookmark Icon (Top Right)
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.bookmark_border,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),

                    // Offer Badge (if available)
                    if (event['offer'] != null)
                      Positioned(
                        bottom: 100,
                        left: 16,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF5B21B6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.local_offer,
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  event['offer'] ?? '',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    // Event Details at Bottom
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Time/Date
                            Text(
                              event['dateTime']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 6),

                            // Event Name and Location
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    event['title']!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                // Calendar/Reminder Icon
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Icon(
                                    Icons.calendar_today,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                          ],
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

  /// Banner Image Widget
  Widget _buildBannerImage(String path) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(path, fit: BoxFit.contain, width: double.infinity),
      ),
    );
  }

  /// Movie Carousel (from Movies Page)
  Widget _buildMovieCarousel(BuildContext context) {
    final PageController controller = PageController(viewportFraction: 0.7);
    final total = sampleMovies.length;

    return SizedBox(
      height: 280,
      child: PageView.builder(
        controller: controller,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final movie = sampleMovies[index % total];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailScreen(movieData: movie),
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
                    Image.asset(
                      movie['bannerImage'] ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[800],
                        child: const Icon(
                          Icons.broken_image,
                          color: Colors.white54,
                          size: 50,
                        ),
                      ),
                    ),
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
                          movie['title'] ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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

  /// Dining Carousel
  Widget _buildDiningCarousel(BuildContext context) {
    final PageController controller = PageController(
      viewportFraction: 0.75,
      initialPage: 1000,
    );
    final total = sampleDining.length;

    return SizedBox(
      height: 320,
      child: PageView.builder(
        controller: controller,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final restaurant = sampleDining[index % total];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DiningDetailScreen(restaurantData: restaurant),
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
                    // Restaurant Image
                    Image.asset(
                      restaurant['image']!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[800],
                        child: const Icon(
                          Icons.broken_image,
                          color: Colors.white54,
                          size: 50,
                        ),
                      ),
                    ),

                    // Gradient Overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.9),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.4, 0.7, 1.0],
                        ),
                      ),
                    ),

                    // Restaurant Details at Bottom
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Restaurant Name
                            Text(
                              restaurant['name']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),

                            // Cuisine Type
                            Text(
                              restaurant['cuisine']!,
                              style: TextStyle(
                                color: Colors.grey[300],
                                fontSize: 13,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),

                            // Rating and Distance Row
                            Row(
                              children: [
                                // Rating
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        restaurant['rating'].toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 2),
                                      const Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),

                                // Distance
                                Icon(
                                  Icons.location_on,
                                  color: Colors.grey[400],
                                  size: 14,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  restaurant['distance']!,
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
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
}