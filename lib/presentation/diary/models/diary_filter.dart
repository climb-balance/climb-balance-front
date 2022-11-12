import 'package:climb_balance/presentation/diary/enums/diary_filter_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/model/story.dart';

part 'diary_filter.freezed.dart';

@freezed
class DiaryFilter with _$DiaryFilter {
  const factory DiaryFilter({
    required DiaryFilterType filter,
    required bool Function(Story story) validator,
  }) = _DiaryFilter;
}
