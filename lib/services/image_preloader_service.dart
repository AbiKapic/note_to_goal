import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'custom_cache_manager.dart';

class ImagePreloaderService {
  static final ImagePreloaderService _instance =
      ImagePreloaderService._internal();
  factory ImagePreloaderService() => _instance;
  ImagePreloaderService._internal();

  final Set<String> _preloadedUrls = <String>{};
  final CustomCacheManager _cacheManager = CustomCacheManager();

  Future<void> preloadImages(BuildContext context, List<String> urls) async {
    final futures = urls.where((url) => !_preloadedUrls.contains(url)).map((
      url,
    ) async {
      try {
        await _cacheManager.downloadFile(url);
        await precacheImage(
          CachedNetworkImageProvider(
            url,
            cacheKey: 'onboarding_${url.hashCode}',
          ),
          context,
        );
        _preloadedUrls.add(url);
      } catch (e) {
        // Continue with other images if one fails
      }
    });

    await Future.wait(futures);
  }

  bool isPreloaded(String url) => _preloadedUrls.contains(url);

  void clearPreloadedUrls() => _preloadedUrls.clear();

  Future<void> clearCache() async {
    await _cacheManager.emptyCache();
    _preloadedUrls.clear();
  }
}
