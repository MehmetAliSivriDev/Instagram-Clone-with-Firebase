import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constant/product_color.dart';

// ignore: must_be_immutable
class CachedImage extends StatelessWidget {
  CachedImage({required String imageURL, super.key}) : _imageURL = imageURL;

  String _imageURL;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: _imageURL,
      progressIndicatorBuilder: (context, url, progress) {
        return SizedBox(
          child: Center(
            child: CircularProgressIndicator(
              value: progress.progress,
              color: ProductColor.instance.black,
            ),
          ),
        );
      },
      errorWidget: (context, url, error) => Container(
        color: ProductColor.instance.red,
        child: const Center(
          child: Text("Error"),
        ),
      ),
    );
  }
}
