import 'package:flutter/material.dart';
import '../movies/movie_data.dart';
import '../movies/movie_detail_screen.dart';

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

            // "IN THE SPOTLIGHT" Heading
            // Spotlight Banner Instead of Text
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

            // // Horizontal Scrolling Event List
            // _buildHorizontalEventList(screenWidth),

            // const SizedBox(height: 20),
            _buildBannerImage('assets/images/blockbuster.png'),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  /// Main Spotlight Carousel (Full-width cards)
  Widget _buildSpotlightCarousel(BuildContext context, double screenWidth) {
    final PageController controller = PageController(
      viewportFraction: 0.85, // Cards take 85% of screen width
      initialPage: 1000,
    );

    final List<Map<String, dynamic>> spotlightEvents = [
      {
        'title': 'Mon, 18 Dec, 1:30 PM',
        'subtitle': 'ISL 2023-24 2025 | Lionel Messi | Delhi',
        'image': 'assets/images/messi_event.jpg',
        'offer': 'Pay only 50% to reserve your tickets',
        'hasOffer': true,
      },
      {
        'title': 'Sat, 25 Nov, 8:00 PM',
        'subtitle':
            'Rolling Loud India | Hip-Hop Festival | Karan Aujla, Central Cee',
        'image': 'assets/images/rolling.jpeg',
        'offer': 'Early bird discount - 30% off',
        'hasOffer': true,
      },
      {
        'title': 'Fri, 15 Dec, 7:00 PM',
        'subtitle': 'PKL 2025: Final',
        'image': 'assets/images/PKL.jpeg',
        'offer': 'Buy 2 Get 1 Free',
        'hasOffer': true,
      },
      {
        'title': 'Sun, 10 Dec, 5:30 PM',
        'subtitle': 'Haloween Party at Noide Social | Delhi NCR',
        'image': 'assets/images/hell.jpg',
        'offer': null,
        'hasOffer': false,
      },
      {
        'title': 'Wed, 20 Dec, 6:00 PM',
        'subtitle': 'Enrique Iglesias Live in Concert - New Show',
        'image': 'assets/images/enrique.jpg',
        'offer': 'Limited seats available',
        'hasOffer': true,
      },
    ];

    final total = spotlightEvents.length;

    return SizedBox(
      height: 450,
      child: PageView.builder(
        controller: controller,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final event = spotlightEvents[index % total];

          return GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Selected: ${event['subtitle']}'),
                  behavior: SnackBarBehavior.floating,
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
                    if (event['hasOffer'])
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
                              event['title']!,
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
                                    event['subtitle']!,
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

  /// Horizontal Scrolling Event List
  Widget _buildHorizontalEventList(double screenWidth) {
    final List<Map<String, String>> events = [
      {'title': 'Music Festival', 'image': 'assets/images/event_music.jpg'},
      {'title': 'Stand-up Comedy', 'image': 'assets/images/event_comedy.jpg'},
      {'title': 'Food Festival', 'image': 'assets/images/event_food.jpg'},
      {'title': 'Tech Summit', 'image': 'assets/images/event_tech.jpg'},
    ];

    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: events.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final event = events[index];

          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: _buildEventBox(
              imagePath: event['image']!,
              title: event['title']!,
              width: screenWidth * 0.35,
            ),
          );
        },
      ),
    );
  }

  /// Event Box Widget
  Widget _buildEventBox({
    required String imagePath,
    required String title,
    required double width,
  }) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade800, width: 1.2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Event Image (Local Asset)
            Expanded(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, color: Colors.white70),
              ),
            ),

            // Title + Bookmark
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              color: Colors.black87,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  const Icon(
                    Icons.bookmark_border,
                    color: Colors.white70,
                    size: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
