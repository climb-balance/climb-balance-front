import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_banner.freezed.dart';

part 'image_banner.g.dart';

@freezed
class ImageBanner with _$ImageBanner {
  const factory ImageBanner({
    @Default('') imageUrl,
    @Default('') redirectUrl,
  }) = _ImageBanner;

  factory ImageBanner.fromJson(Map<String, dynamic> json) =>
      _$ImageBannerFromJson(json);
}

@freezed
class ImageBannerList with _$ImageBannerList {
  const factory ImageBannerList({required List<ImageBanner> storyList}) =
      _ImageBannerList;

  factory ImageBannerList.fromJson(Map<String, dynamic> json) =>
      _$ImageBannerListFromJson(json);
}
