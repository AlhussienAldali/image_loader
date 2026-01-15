import 'package:flutter/material.dart';
import 'package:image_loader/constants.dart';
import 'package:image_loader/features/random_image/repo/image_repository.dart';
import 'package:image_loader/utils/remote_image.dart';

///Main screen
class RandomImageScreen extends StatefulWidget {
  ///Widget constructor
  const RandomImageScreen({super.key});

  @override
  State<RandomImageScreen> createState() => _RandomImageScreenState();
}

class _RandomImageScreenState extends State<RandomImageScreen> {
  final ImageRepository _repository = ImageRepository();

  String? _imageUrl;
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _loadImage() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final imageUrl = await _repository.fetchFromApi();
      setState(() {
        _imageUrl = imageUrl;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load image. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_imageUrl != null)
              RemoteImage(imageUrl: _imageUrl!, size: imageSize)
            else if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _isLoading ? null : _loadImage,
              child: const Text(generateImageButtonText),
            ),
          ],
        ),
      ),
    );
  }
}
