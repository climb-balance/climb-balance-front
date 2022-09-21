import 'package:carousel_slider/carousel_slider.dart';
import 'package:climb_balance/presentation/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ImageBannerPreview extends ConsumerStatefulWidget {
  final double imageHeight;

  const ImageBannerPreview({Key? key, this.imageHeight = 200})
      : super(key: key);

  @override
  ConsumerState<ImageBannerPreview> createState() => _ImageBannerPreviewState();
}

class _ImageBannerPreviewState extends ConsumerState<ImageBannerPreview> {
  int currentImageBannerIdx = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imageBanners =
        ref.watch(homeViewModelProvider.select((value) => value.imageBanners));
    return Stack(
      children: [
        CarouselSlider(
          items: imageBanners
              .map(
                (imageBanner) => ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(widget.imageHeight / 8),
                  ),
                  child: Image.network(imageBanner.imageUrl, fit: BoxFit.fill),
                ),
              )
              .toList(),
          options: CarouselOptions(
            height: widget.imageHeight,
            autoPlay: true,
            viewportFraction: 1,
            onPageChanged: (index, _) {
              setState(() {
                currentImageBannerIdx = index;
              });
            },
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imageBanners.map(
                (imageBanner) {
                  int index = imageBanners.indexOf(imageBanner);
                  return Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: theme.colorScheme.surface,
                      ),
                      shape: BoxShape.circle,
                      color: currentImageBannerIdx == index
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface,
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
