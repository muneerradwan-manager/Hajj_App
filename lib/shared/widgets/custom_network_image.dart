import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomCachedImage extends StatelessWidget {
  const CustomCachedImage({
    super.key,
    required this.imageUrl,
    this.placeholder,
    this.errorWidget,
    this.emptyWidget,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius = 12,
    this.heroTag,
    this.enableFullScreen = true,
  });

  final String? imageUrl;

  /// For loading (only when url is valid)
  final WidgetBuilder? placeholder;

  /// For network/load error (only when url is valid)
  final Widget Function(BuildContext context, Object error)? errorWidget;

  /// Shown when imageUrl is null / empty / whitespace
  final WidgetBuilder? emptyWidget;

  final BoxFit fit;
  final double? width;
  final double? height;
  final double borderRadius;
  final Object? heroTag;
  final bool enableFullScreen;

  bool get _hasValidUrl {
    final u = imageUrl;
    return u != null && u.trim().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    // 1) url null/empty => show emptyWidget (or default)
    if (!_hasValidUrl) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: emptyWidget?.call(context) ??
            _DefaultEmpty(width: width, height: height),
      );
    }

    final url = imageUrl!.trim();
    final tag = heroTag ?? url;

    final img = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: url,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, _) =>
            placeholder?.call(context) ??
            _DefaultPlaceholder(width: width, height: height),
        errorWidget: (context, _, error) =>
            errorWidget?.call(context, error) ?? const _DefaultError(),
      ),
    );

    if (!enableFullScreen) return Hero(tag: tag, child: img);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => _FullScreenImageViewer(imageUrl: url, heroTag: tag),
          ),
        );
      },
      child: Hero(tag: tag, child: img),
    );
  }
}

class _FullScreenImageViewer extends StatelessWidget {
  const _FullScreenImageViewer({required this.imageUrl, required this.heroTag});

  final String imageUrl;
  final Object heroTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Hero(
            tag: heroTag,
            child: InteractiveViewer(
              minScale: 1.0,
              maxScale: 4.0,
              panEnabled: true,
              scaleEnabled: true,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
                placeholder: (context, _) => const _FullScreenLoader(),
                errorWidget: (context, _, _) => const _DefaultError(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DefaultPlaceholder extends StatelessWidget {
  const _DefaultPlaceholder({this.width, this.height});
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: const SizedBox(
        width: 22,
        height: 22,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}

class _FullScreenLoader extends StatelessWidget {
  const _FullScreenLoader();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 26,
        height: 26,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}

class _DefaultError extends StatelessWidget {
  const _DefaultError();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade300,
      alignment: Alignment.center,
      child: const Icon(Icons.broken_image_outlined, size: 28),
    );
  }
}

class _DefaultEmpty extends StatelessWidget {
  const _DefaultEmpty({this.width, this.height});
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey.shade100,
      alignment: Alignment.center,
      child: const Icon(Icons.image_not_supported_outlined, size: 28),
    );
  }
}