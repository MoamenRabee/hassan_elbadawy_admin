import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LoadingImage extends StatelessWidget {
  LoadingImage({
    super.key,
    required this.src,
    this.height = double.infinity,
    this.width = double.infinity,
  });

  String src;

  double? height;
  double? width;

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      placeholderErrorBuilder: ((context, error, stackTrace) {
        return Image.asset("assets/images/spinner.gif");
      }),
      placeholder: const AssetImage(
        "assets/images/spinner.gif",
      ),
      image: CachedNetworkImageProvider(src),
      placeholderFit: BoxFit.cover,
      fit: BoxFit.cover,
      imageErrorBuilder: (context, obj, stack) {
        return Image.asset("assets/images/spinner.gif");
      },
      fadeInDuration: const Duration(milliseconds: 300),
      fadeOutDuration: const Duration(milliseconds: 300),
      height: height,
      width: width,
    );
  }
}
