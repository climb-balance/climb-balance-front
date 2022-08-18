import 'dart:math';

import 'package:climb_balance/models/expert_profile.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    @Default('default') String nickName,
    @Default('https://as1.ftcdn.net/v2/jpg/03/53/11/00/1000_F_353110097_nbpmfn9iHlxef4EDIhXB1tdTD0lcWhG9.jpg')
        String profileImage,
    @Default('') String description,
    @Default('') String token,
    @Default(1234) int uniqueTag,
    @Default(-1) int height,
    @Default(-1) int weight,
    @Default(false) bool isExpert,
    @Default(0) int rank,
    ExpertProfile? expertProfile,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, Object?> json) =>
      _$UserProfileFromJson(json);
}

UserProfile genRandomUser({bool isExpert = true}) {
  Random random = Random(1);
  if (isExpert) {
    return const UserProfile(
      nickName: '심규진',
      profileImage:
          'https://lh3.googleusercontent.com/TpNzjXhScTNiLV21fzH-lsNYczV5u0fy6bg-mhjZBEf799ftEi3s5kfjJL1O7ggQAq75zduWKMyh7oQp9BAHbYOiss66x_uzl8TI6bmKT2tfettgWjBPh0v9vDoT14SAjzb2DS8FL-WpvtjK8UTkmibcCDR67Kg12xOfQQhY5RvBKjfh3TryXcq6m-TyNKEDPOAXlQDgGyic7eWVVDQDU96QQ_cBKOPkunrxAAX8X53IcAjYXzqnDtvmH4fgaawbdTjUTDGjrOsrhqOVNm44oka6ANXuT1w1KxzVZsSaOLwHXZOlRiyvmCGEvbGYHBa_B0kk16PBmi9LXXQC3QFmYCBD2XCjY8CAYlxO1Nih8j5L8U70_oiLUFL-sEuFfqYIGK0m_5eeExpnl77Z4MHqUe4nuZQqQ-PClHgLYIFfLjeoHzJZxFUvLX_MkrROXRkw1kVttea22uIFIxs8PX6e1IlltcBnLkNFhVuolPaXdeNwm7SbpV_GZQjhJJaSQ6JAYrA6jZfFLZUbmBlw5ZQYgu-kf8gGX_X8cbt9HbkN1FXQ4YxJj2aZLPZYkN_rkCNhi_h9mOtTBM-TKF2deRmzJszbkGLSQIx4rCRje8PBVC_Ws1PvsYQqRu_PWb8x-O1O-JaiC2U4j5ZFAvRsFg7TH-pStiuMV9gIka3Bx4tCRXr1FZsDUg1POByz0b1L2ydtCK85ARmIHYzIgEFroO1ETIfqI3ioA1YHHOUNt2xr694yB7ShnIUp_7GFEhr_ebs=w1003-h1336-no?authuser=0',
      uniqueTag: 1234,
      height: 160,
      weight: 50,
      description: '안녕하세요. 즐거운 클라이밍해요!!',
      isExpert: true,
      rank: 2,
    );
  }
  return UserProfile(
    nickName: '심규진',
    profileImage:
        'https://lh3.googleusercontent.com/TpNzjXhScTNiLV21fzH-lsNYczV5u0fy6bg-mhjZBEf799ftEi3s5kfjJL1O7ggQAq75zduWKMyh7oQp9BAHbYOiss66x_uzl8TI6bmKT2tfettgWjBPh0v9vDoT14SAjzb2DS8FL-WpvtjK8UTkmibcCDR67Kg12xOfQQhY5RvBKjfh3TryXcq6m-TyNKEDPOAXlQDgGyic7eWVVDQDU96QQ_cBKOPkunrxAAX8X53IcAjYXzqnDtvmH4fgaawbdTjUTDGjrOsrhqOVNm44oka6ANXuT1w1KxzVZsSaOLwHXZOlRiyvmCGEvbGYHBa_B0kk16PBmi9LXXQC3QFmYCBD2XCjY8CAYlxO1Nih8j5L8U70_oiLUFL-sEuFfqYIGK0m_5eeExpnl77Z4MHqUe4nuZQqQ-PClHgLYIFfLjeoHzJZxFUvLX_MkrROXRkw1kVttea22uIFIxs8PX6e1IlltcBnLkNFhVuolPaXdeNwm7SbpV_GZQjhJJaSQ6JAYrA6jZfFLZUbmBlw5ZQYgu-kf8gGX_X8cbt9HbkN1FXQ4YxJj2aZLPZYkN_rkCNhi_h9mOtTBM-TKF2deRmzJszbkGLSQIx4rCRje8PBVC_Ws1PvsYQqRu_PWb8x-O1O-JaiC2U4j5ZFAvRsFg7TH-pStiuMV9gIka3Bx4tCRXr1FZsDUg1POByz0b1L2ydtCK85ARmIHYzIgEFroO1ETIfqI3ioA1YHHOUNt2xr694yB7ShnIUp_7GFEhr_ebs=w1003-h1336-no?authuser=0',
    uniqueTag: 1234,
    height: 160,
    weight: 50,
    description: '안녕하세요. 즐거운 클라이밍해요!!',
    rank: random.nextInt(2) - 1,
  );
}
