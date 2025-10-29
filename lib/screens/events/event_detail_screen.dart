import 'package:flutter/material.dart';

class EventDetailScreen extends StatefulWidget {
  final Map<String, dynamic> eventData;

  const EventDetailScreen({
    Key? key,
    required this.eventData,
  }) : super(key: key);

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  int selectedDateIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          // App Bar with Banner Image
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    widget.eventData['image'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(color: Colors.grey[900]),
                  ),
                  // Gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                          Colors.black,
                        ],
                        stops: const [0.0, 0.7, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event Title
                  Text(
                    widget.eventData['title'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Category Tags
                  _buildCategoryTags(),

                  const SizedBox(height: 16),

                  // Event Info Cards
                  _buildInfoCard(
                    icon: Icons.calendar_today,
                    title: 'Date & Time',
                    subtitle: widget.eventData['dateTime'] ?? 'TBA',
                  ),

                  const SizedBox(height: 12),

                  _buildInfoCard(
                    icon: Icons.location_on,
                    title: 'Venue',
                    subtitle: widget.eventData['venue'] ?? 'TBA',
                  ),

                  const SizedBox(height: 12),

                  _buildInfoCard(
                    icon: Icons.language,
                    title: 'Language',
                    subtitle: widget.eventData['language'] ?? 'English',
                  ),

                  const SizedBox(height: 20),

                  // About Section
                  const Text(
                    'About',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.eventData['description'] ?? 'No description available.',
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Terms & Conditions
                  _buildExpandableSection(
                    title: 'Terms & Conditions',
                    content: widget.eventData['terms'] ?? 'Please check with the organizer.',
                  ),

                  const SizedBox(height: 16),

                  // Available Dates (if any)
                  if (widget.eventData['availableDates'] != null)
                    _buildDateSelection(),

                  const SizedBox(height: 30),

                  // Book Now Button
                  _buildBookButton(),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTags() {
    final categories = widget.eventData['categories'] as List<String>? ?? [];
    
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categories.map((category) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.purple.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.purple.withOpacity(0.5)),
          ),
          child: Text(
            category,
            style: const TextStyle(
              color: Colors.purple,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[800]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.purple, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required String content,
  }) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      iconColor: Colors.white,
      collapsedIconColor: Colors.grey,
      backgroundColor: Colors.grey[900],
      collapsedBackgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[800]!),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[800]!),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            content,
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateSelection() {
    final dates = widget.eventData['availableDates'] as List? ?? [];
    
    if (dates.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Date',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dates.length,
            itemBuilder: (context, index) {
              final date = dates[index];
              final isSelected = selectedDateIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDateIndex = index;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF6366F1)
                        : Colors.grey[900],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF6366F1)
                          : Colors.grey[800]!,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        date['date'] ?? '',
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[400],
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        date['day'] ?? '',
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[500],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBookButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Proceeding to ticket booking...'),
              backgroundColor: Color(0xFF6366F1),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red[600],
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Book Now',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}