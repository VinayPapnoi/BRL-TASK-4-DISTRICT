import 'package:flutter/material.dart';

class MovieDetailScreen extends StatelessWidget {
  final String title;
  final String image;

  const MovieDetailScreen({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> nextDates = List.generate(
      4,
      (i) => "${DateTime.now().add(Duration(days: i)).day} "
          "${_getMonthName(DateTime.now().add(Duration(days: i)).month)}",
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🎬 Poster Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
              ),
            ),
            const SizedBox(height: 16),

            // 🎞️ Movie Title
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // 📝 Placeholder Synopsis
            const Text(
              "Synopsis:\n\n"
              "This is a placeholder description for the selected movie. "
              "When you connect your API, you can display the movie’s official synopsis, "
              "cast, director, and ratings here.",
              style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
            ),

            const SizedBox(height: 24),

            // 🎟️ Dates to Buy Tickets
            const Text(
              "Available Dates:",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),

            Wrap(
              spacing: 10,
              children: nextDates
                  .map(
                    (date) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[700]!),
                      ),
                      child: Text(
                        date,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                  .toList(),
            ),

            const SizedBox(height: 30),

            // 🎫 Dummy Buy Ticket Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Ticket purchase feature coming soon!"),
                    ),
                  );
                },
                child: const Text(
                  "Buy Tickets",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return months[month - 1];
  }
}
