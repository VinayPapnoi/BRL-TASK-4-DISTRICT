import 'package:flutter/material.dart';
import '../../widgets/movie_box.dart';
import 'movie_detail_screen.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({Key? key}) : super(key: key);

  final List<Map<String, String>> movies = const [
    {
      'title': 'Dune: Part Two',
      'image': 'https://via.placeholder.com/200x300?text=Dune+2',
    },
    {
      'title': 'Joker: Folie à Deux',
      'image': 'https://via.placeholder.com/200x300?text=Joker+2',
    },
    {
      'title': 'Deadpool & Wolverine',
      'image': 'https://via.placeholder.com/200x300?text=Deadpool+3',
    },
    {
      'title': 'Inside Out 2',
      'image': 'https://via.placeholder.com/200x300?text=Inside+Out+2',
    },
    {
      'title': 'Oppenheimer',
      'image': 'https://via.placeholder.com/200x300?text=Oppenheimer',
    },
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
              _buildBannerImage('assets/images/spotlight_banner.png'),
              _buildMovieCarousel(context),
              const SizedBox(height: 20),
              _buildBannerImage('assets/images/below-spotlight.png'),
              const SizedBox(height: 20),
              _buildHorizontalMovieList(screenWidth),
              const SizedBox(height: 20),
              _buildBannerImage('assets/images/explore_icon.png'),
              const SizedBox(height: 20),

              // 🟢 Two side-by-side boxes
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

              const SizedBox(height: 20),

              // 🟢 NEW horizontal banner below boxes
              _buildBannerImage('assets/images/only_theatre.png'),

              const SizedBox(height: 40),
              // 🟩 Grid of 29 Movie Boxes (2 columns)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // ✅ 2 boxes per row
                    crossAxisSpacing: 12, // horizontal space
                    mainAxisSpacing: 16, // vertical space
                    childAspectRatio:
                        0.68, // adjust height/width ratio for nice proportions
                  ),
                  itemCount: 29,
                  itemBuilder: (context, index) {
                    return MovieBox(
                      imagePath:
                          "https://via.placeholder.com/300x450?text=Movie+$index",
                      title: "Movie $index",
                      isNetworkImage: true,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔸 Common banner image
  Widget _buildBannerImage(String path) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(path, fit: BoxFit.contain, width: double.infinity),
      ),
    );
  }

  /// 🔸 Spotlight Carousel
  Widget _buildMovieCarousel(BuildContext context) {
    final PageController controller = PageController(
      viewportFraction: 0.7,
      initialPage: 1000,
    );

    final List<Map<String, String>> movies = [
      {
        'title': 'Dune: Part Two',
        'image': 'https://via.placeholder.com/200x300?text=Dune+2',
      },
      {
        'title': 'Joker',
        'image': 'https://via.placeholder.com/200x300?text=Joker+2',
      },
      {
        'title': 'Deadpool & Wolverine',
        'image': 'https://via.placeholder.com/200x300?text=Deadpool+3',
      },
      {
        'title': 'Inside Out 2',
        'image': 'https://via.placeholder.com/200x300?text=Inside+Out+2',
      },
      {
        'title': 'Oppenheimer',
        'image': 'https://via.placeholder.com/200x300?text=Oppenheimer',
      },
      {
        'title': 'Venom 3',
        'image': 'https://via.placeholder.com/200x300?text=Venom+3',
      },
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

  /// 🔸 Horizontal movie list (3 boxes)
  Widget _buildHorizontalMovieList(double screenWidth) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 3,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: MovieBox(
              imagePath:
                  "https://via.placeholder.com/140x180?text=Movie+$index",
              title: "Movie Title $index",
              isNetworkImage: true,
              width: screenWidth * 0.35,
            ),
          );
        },
      ),
    );
  }

  /// 🔸 Static two image boxes (local)
  Widget _buildImageBox(BuildContext context, String imagePath) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: (screenWidth - 48) / 2,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade800, width: 1.2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
          width: double.infinity,
        ),
      ),
    );
  }
}
