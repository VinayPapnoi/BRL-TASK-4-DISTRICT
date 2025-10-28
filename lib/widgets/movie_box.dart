// lib/widgets/movie_box.dart
import 'package:flutter/material.dart';
import '../screens/movies/movie_detail_screen.dart';

class MovieBox extends StatelessWidget {
  final Map<String, dynamic> movieData;
  final double? width;

  const MovieBox({
    Key? key,
    required this.movieData,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String title = movieData['title'] ?? 'Untitled';
    final String banner = movieData['bannerImage'] ?? '';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(movieData: movieData),
          ),
        );
      },
      child: Container(
        width: width ?? 160,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade800, width: 1.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AspectRatio(
                aspectRatio: 3 / 4,
                child: banner.startsWith('assets/')
                    ? Image.asset(
                        banner,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        banner,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[800],
                          child: const Icon(Icons.broken_image,
                              color: Colors.white54),
                        ),
                      ),
              ),

              Container(
                color: Colors.black87,
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.bookmark_border,
                          color: Colors.white70, size: 18),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.black87,
                            content: Text('"$title" added to watchlist'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
