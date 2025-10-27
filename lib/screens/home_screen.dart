import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';
import 'profile_screen.dart';
import '../providers/auth_provider.dart';
import '../utils/colors.dart';

import 'sub_screens/dining_page.dart';
import 'sub_screens/events_page.dart';
import 'sub_screens/for_you_page.dart';
import 'sub_screens/movie_page.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedTabIndex = 0;

  String _city = "Loading...";
  String _country = "";

  final List<String> _tabs = [
    'FOR YOU',
    'DINING',
    'EVENTS',
    'MOVIES',
    
    
  ];

  final List<Color> _tabColors = [
    AppColors.forYouPurple,
    AppColors.diningRed,
    AppColors.eventsYellow,
    AppColors.moviesBlue,
    
    
  ];
  

  final List<Widget> _pages = [
  ForYouPage(),
  DiningPage(),
  EventsPage(),
  MoviesPage(),
  
  
];


  final List<String> _searchHints = [
    'Search for events, movies, restaurants...',
    'Search for restaurants, cuisines, dishes...',
    'Search for concerts, shows, exhibitions...',
    'Search for movies, showtimes, theaters...',
    
    
  ];

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      loc.Location location = loc.Location();
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          setState(() {
            _city = "Location Off";
            _country = "";
          });
          return;
        }
      }

      loc.PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == loc.PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != loc.PermissionStatus.granted) {
          setState(() {
            _city = "Unknown";
            _country = "";
          });
          return;
        }
      }

      loc.LocationData myLocation = await location.getLocation();

      List<Placemark> placemarks = await placemarkFromCoordinates(
        myLocation.latitude!,
        myLocation.longitude!,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String topLine = place.subLocality ?? place.name ?? "Unknown";
        String bottomLine = [
          if (place.street != null && place.street!.isNotEmpty) place.street,
          if (place.locality != null && place.locality!.isNotEmpty)
            place.locality,
          if (place.subAdministrativeArea != null &&
              place.subAdministrativeArea!.isNotEmpty)
            place.subAdministrativeArea,
        ].join(', ');

        setState(() {
          _city = topLine;
          _country = bottomLine;
        });
      }
    } catch (e) {
      debugPrint("Error getting location: $e");
      setState(() {
        _city = "Error";
        _country = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        

      body: Stack(
       
        
        children: [
          Container(color: const Color(0xFF000000)),

          // Top gradient
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight * 0.25,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topCenter,
                  radius: 1.2,
                  colors: [
                    _tabColors[_selectedTabIndex].withOpacity(0.4),
                    _tabColors[_selectedTabIndex].withOpacity(0.2),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Top location bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.white, size: 20),
                          const SizedBox(width: 4),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    _city,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Icon(Icons.keyboard_arrow_down,
                                      color: Colors.white, size: 20),
                                ],
                              ),
                              Text(
                                _country,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Profile icon
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileScreen(),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.grey.shade800,
                          child: const Icon(Icons.person, color: Colors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
                ),

                // Search bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: _searchHints[_selectedTabIndex],
                        hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                        prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ),

                // Tabs row (updated)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(_tabs.length, (index) {
                      final isSelected = _selectedTabIndex == index;
                      final icons = [
                        FontAwesomeIcons.wandMagicSparkles,
                        Icons.restaurant,
                        FontAwesomeIcons.guitar,
                        FontAwesomeIcons.clapperboard,
                        Icons.shopping_bag,
                        Icons.local_activity,
                      ];

                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedTabIndex = index),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(icons[index],
                                    size: screenWidth * 0.08,
                                    color: isSelected ? _tabColors[index] : Colors.grey),
                                SizedBox(height: screenHeight * 0.01),
                                Text(
                                  _tabs[index],
                                  style: TextStyle(
                                    color: isSelected ? _tabColors[index] : Colors.grey.shade400,
                                    fontSize: screenWidth * 0.03,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: screenHeight * 0.005),
                                Container(
                                  height: 2,
                                  width: screenWidth * 0.08,
                                  color: isSelected ? _tabColors[index] : Colors.transparent,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
               Expanded(
                child: IndexedStack(
                   index: _selectedTabIndex,
                   children:_pages,
                   ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
