import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// Displays a cached remote image with a lightweight loading indicator.
///
/// We intentionally keep this widget stateless and UI-only so that
/// image fetching and error handling remain outside the view layer.

class RemoteImage extends StatelessWidget {
  /// image link provided as a string
  final String imageUrl;
  /// Size of the widget, by default 240
  final double? size;
/// widget constructor
  const RemoteImage({super.key, required this.imageUrl, this.size});

  @override
  Widget build(BuildContext context) {
    final double dimension = size ?? 240;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: dimension,
        height: dimension,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (_, _) =>
              const Center(child: CircularProgressIndicator(strokeWidth: 2)),
          errorWidget: (_, _, _) =>
              const Center(child: Icon(Icons.broken_image, size: 40)),
          fadeInDuration: const Duration(milliseconds: 300),
        ),
      ),
    );
  }
}
