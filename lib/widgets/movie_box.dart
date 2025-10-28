import 'package:flutter/material.dart';

class MovieBox extends StatelessWidget {
  final String imagePath;
  final String? title;
  final double? width;
  final double? height;
  final bool isNetworkImage;

  const MovieBox({
    Key? key,
    required this.imagePath,
    this.title,
    this.width,
    this.height,
    this.isNetworkImage = false, // use true for network images
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: width ?? (screenWidth - 48) / 2,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade800, width: 1.2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🔹 Image Section
            isNetworkImage
                ? Image.network(
                    imagePath,
                    height: height ?? 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    imagePath,
                    height: height ?? 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),

            // 🔹 Optional Title Section
            if (title != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title!,
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
      ),
    );
  }
}
