import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future<void> configureApp() {
  WidgetsFlutterBinding.ensureInitialized();

  return _cacheAllSvgImages();
}

Future<void> _cacheAllSvgImages() async {
  final manifestJson = await rootBundle.loadString('AssetManifest.json');
  final svgsPaths = (jsonDecode(manifestJson) as Map<String, dynamic>).keys
      .where((key) => key.startsWith('assets/images/') && key.endsWith('.svg'));

  for (final svgPath in svgsPaths) {
    final loader = SvgAssetLoader(svgPath);
    await svg.cache.putIfAbsent(
      loader.cacheKey(null),
      () => loader.loadBytes(null),
    );
  }
}
