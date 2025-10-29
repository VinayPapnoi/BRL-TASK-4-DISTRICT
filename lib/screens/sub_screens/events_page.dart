import 'package:flutter/material.dart';

class Event {
  final String title;
  final String date;
  final String location;
  final String image;
  final String category;

  Event({
    required this.title,
    required this.date,
    required this.location,
    required this.image,
    required this.category,
  });
}

class EventsPage extends StatelessWidget {
  EventsPage({super.key});

  final List<Map<String, String>> weekCategories = [
    {"title": "Nightlife", "image": "assets/images/nightlife.jpg"},
    {"title": "Comedy", "image": "assets/images/comedy.jpg"},
    {"title": "Music", "image": "assets/images/music.jpg"},
    {"title": "Food & Drinks", "image": "assets/images/food.jpg"},
    {"title": "Sports", "image": "assets/images/sports.jpg"},
  ];

  final List<Event> featuredEvents = [
    Event(
      title: "PKL 2025: Final",
      date: "Fri, 31 Oct, 8:00 PM",
      location: "Thyagaraj Stadium, Delhi/NCR",
      image: "assets/images/pkl.jpg",
      category: "Sports",
    ),
    Event(
      title: "Sunidhi Chauhan India Tour 2025",
      date: "Sat, 27 Dec, 7:00 PM",
      location: "Venue to be announced",
      image: "assets/images/sunidhi.jpg",
      category: "Music",
    ),
  ];

  final List<Map<String, String>> exploreCategories = [
    {"title": "Music", "image": "assets/images/music_icon.png"},
    {"title": "Comedy", "image": "assets/images/comedy_icon.png"},
    {"title": "Performances", "image": "assets/images/performance_icon.png"},
    {"title": "Festivals", "image": "assets/images/festival_icon.png"},
    {"title": "Nightlife", "image": "assets/images/nightlife_icon.png"},
    {"title": "Sports", "image": "assets/images/sports_icon.png"},
    {"title": "Food & Drinks", "image": "assets/images/food_icon.png"},
    {"title": "Events in IIT", "image": "assets/images/social_icon.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 15, 23),
     


      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
       
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  child: Image.asset(
                    "assets/images/banner_halloween.jpg", // <-- your banner image here
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  
                ),
              ],
            ),

           
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            
                  const Text(
                    "What's happening this week",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 90,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: weekCategories.length,
                      itemBuilder: (context, index) {
                        final cat = weekCategories[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Column(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.purple, width: 2),
                                  image: DecorationImage(
                                    image: AssetImage(cat["image"]!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                cat["title"]!,
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

              
                  const Text(
                    "Featured events",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 230,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: featuredEvents.length,
                      itemBuilder: (context, index) {
                        final event = featuredEvents[index];
                        return Container(
                          width: 180,
                          margin: const EdgeInsets.only(right: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: const Color(0xFF1A1A1A),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(16)),
                                child: Image.asset(
                                  event.image,
                                  height: 100,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      event.location,
                                      style: const TextStyle(
                                        color: Colors.purpleAccent,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      event.title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      event.date,
                                      style: const TextStyle(
                                          color: Colors.white70, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                 
                   const Text(
                   "Explore events",
                    style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                   ),
                  ),
                const SizedBox(height: 12),

               ListView.builder(
               shrinkWrap: true,
               physics: const NeverScrollableScrollPhysics(),
               itemCount: exploreCategories.length,
               itemBuilder: (context, index) {
               final cat = exploreCategories[index];
               return Container(
               margin: const EdgeInsets.only(bottom: 14),
               decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(16),
               color: const Color(0xFF1A1A1A),
               boxShadow: [
               BoxShadow(
               color: Colors.black.withOpacity(0.25),
               blurRadius: 6,
               offset: const Offset(0, 3),
             ),
            ],
           ),
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              cat["image"]!,
              height: 210,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              cat["title"]!,
              style: const TextStyle(
                color: Colors.amberAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
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
    );
  }
}
