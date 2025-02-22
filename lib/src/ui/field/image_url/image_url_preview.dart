import 'dart:io';

import 'package:flutter/widgets.dart';

class ImageUrlPreview extends StatelessWidget {
  final String url;
  final double aspectRatio;
  final BoxFit fit;
  final double? maxWidth;
  final double? maxHeight;

  const ImageUrlPreview({
    required this.url,
    required this.aspectRatio,
    required this.fit,
    required this.maxWidth,
    required this.maxHeight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxWidth ?? double.infinity,
        maxHeight: maxHeight ?? double.infinity,
      ),
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Builder(builder: (context) {
          final isNetworkImage = url.startsWith('http');
          final isAssetImage = url.startsWith('assets/');
          final isFileImage = url.startsWith('file://');
          if (isNetworkImage) {
            return Image.network(
              url,
              fit: fit,
            );
          }
          if (isAssetImage) {
            return Image.asset(
              url,
              fit: fit,
            );
          }
          if (isFileImage) {
            return Image.file(
              File(url),
              fit: fit,
            );
          }
          return const Placeholder();
        }),
      ),
    );
  }
}
