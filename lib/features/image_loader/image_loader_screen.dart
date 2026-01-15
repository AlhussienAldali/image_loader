import 'package:flutter/material.dart';

import '../../utils/remote_image.dart';

///Main screen
class ImageLoader extends StatefulWidget {
  ///Widget constructor
  const ImageLoader({super.key});

  @override
  State<ImageLoader> createState() => _ImageLoaderState();
}

class _ImageLoaderState extends State<ImageLoader> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Center(
          child: RemoteImage(
            imageUrl:
                'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
          ),
        ),
      ),
    );
  }
}
