import 'package:freezed_annotation/freezed_annotation.dart';

part 'stories_filter.freezed.dart';

@freezed
class StoriesFilter with _$StoriesFilter {
  const factory StoriesFilter.noFilter() = NoFilter;

  const factory StoriesFilter.aiOnly() = AiOnly;

  const factory StoriesFilter.expertOnly() = ExpertOnly;
}
