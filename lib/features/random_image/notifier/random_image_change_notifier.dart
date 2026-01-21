import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:image_loader/features/random_image/repo/image_repository.dart';
import 'package:image_loader/utils/color_helper.dart';

/// A controller responsible for managing the UI state of the random image screen.
///
/// `ChangeNotifier` is used to encapsulate screen-specific state and side effects
/// (loading, error handling, image fetching, and background color updates),
/// keeping the UI declarative and the architecture intentionally minimal.
class RandomImageChangeNotifier extends ChangeNotifier {
  RandomImageChangeNotifier(this._repository);

  final ImageRepository _repository;

  String? imageUrl;
  Color backgroundColor = Colors.yellow;
  bool isLoading = false;
  String? errorMessage;

  Future<void> loadImage() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final url = await _repository.fetchFromApi();
      imageUrl = url;

      // Fetch image bytes for color extraction
      final response = await http.get(Uri.parse(url));

      await _updateBackgroundColor(response.bodyBytes);

      isLoading = false;
      notifyListeners();
    } catch (_) {
      isLoading = false;
      errorMessage = 'Failed to load image. Please try again.';
      notifyListeners();
    }
  }

  Future<void> _updateBackgroundColor(Uint8List imageBytes) async {
    final color = await extractDominantColor(imageBytes);
    backgroundColor = color;
  }
}
