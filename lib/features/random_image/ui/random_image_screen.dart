import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_loader/features/random_image/notifier/random_image_change_notifier.dart';
import 'package:image_loader/features/random_image/repo/image_repository.dart';
import 'package:image_loader/utils/fancy_logo_loader.dart';
import 'package:image_loader/utils/remote_image.dart';
import 'package:provider/provider.dart';

///Main screen for Displaying all UI components
class RandomImageScreen extends StatelessWidget {
  const RandomImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RandomImageChangeNotifier(ImageRepository())..loadImage(),
      child: const _RandomImageView(),
    );
  }
}

class _RandomImageView extends StatelessWidget {
  const _RandomImageView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RandomImageChangeNotifier>();

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1️⃣ Base dynamic color
          AnimatedContainer(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
            color: controller.backgroundColor,
          ),

          // 2️⃣ Smooth gradient overlay with BlendMode
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.05),
                  Colors.black.withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
              child: Container(color: Colors.transparent),
            ),
          ),

          // 3️⃣ Main content (logo + image)
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (controller.isLoading)
                  SizedBox(
                    height: 240,
                    child: Center(
                      child: FancyLogoLoader(
                        color: Colors.white,
                        logo: Image.asset(
                          'assets/logo-o.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  )
                else if (controller.imageUrl != null)
                  RemoteImage(imageUrl: controller.imageUrl!, size: 240)
                else if (controller.errorMessage != null)
                  Text(
                    controller.errorMessage!,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: controller.isLoading ? null : controller.loadImage,
                  child: const Text('Another'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
