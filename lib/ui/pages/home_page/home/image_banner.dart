import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageBanner extends ConsumerStatefulWidget {
  const ImageBanner({Key? key}) : super(key: key);

  @override
  ConsumerState<ImageBanner> createState() => _ImageBannerState();
}

class _ImageBannerState extends ConsumerState<ImageBanner> {
  static const double _height = 200;
  final List<String> images = [
    'https://lh3.googleusercontent.com/9kXVxj6DVJFXa9xEoKHx83_1lmQ_G3Zo497kuNIHsu1OOHArh2ksJkai7AJF6G2XE_OraAfYhG2ngkX3clh7OOHgnBktQrxK_h1AdC81d8qtY4ytuwdVJNgq9skfUXPvzrfxO8tKN1K-UQzU25Z45ovJGQpjwDlBzpraVBnaOsJvFf5uKO7zYHyHZJsACqsfr6miX0XkF0xf8qZbxbLXYPOh8cw1wztmWIdqvsdvY41rPaiLXXgAr1SNaWatSAF2bSYPiBRwfRVu9HIzKPxfFiJ54V6X_Bj1wDMzdr0-uX0YZhnN4ZVupw6-kd1RIMrDnasQAeM-O6dGfJCHshhhYx2JoCT-UnXAHtcYo4FpBrjV_W6t0BEjhCfCREFW1aA1Bb31Xei5U7-sx6Nh8CT03DUQS_BNGjkBWXb-6SHajMKrRALBuDHMXgkzaCDcH5_l7UNyP89APMM14gCr9i-Rrt-UnayAmPt3n-YulJyv41Ns84grF5vJCmOG2mt3tA3pi878RAa2SJbBMoO1ZVphUHk0ooGE-Gh3VsfwfLXOKKitN31UcMe46evrHjeRE4GV-jji6Auc-sJvz7IKnxZWlq46taRrinIfgy7T3xPGzcuY9ZpH-GW4RzcaWLGfAm3xrIq5UG3ShDiAaDAw5E2fFwCN2VjKQi1cM_2GB0OVmsuoTxpdO167wCg7KwhaYm8ujYuqZBICGiXOtvUQh5bVNTPVak0vPLSA1fLhnZZklS2Q_rjh_8eDs4f1fePYK5k=w1079-h605-no?authuser=0',
    'https://lh3.googleusercontent.com/lfolagpSibJo9xQBHimYcCZNvYuyvxtccVqIdiaZWUwduT4VyS1Xi19TNLu3dmS8ftEU7548hfF3CvGQpNqvPXuk8iIVQoIDHWdjBOGDqe1jLhS-N42DALbUd4Z39AhZIWgpmxjN795sZxznkSEDSL3_rEV5FaZCUvciu7lIjnFrj_O1ybqcKLfEghNZcVyrvJdkBcAyJyXVEHQKrdgrH024cr8Yppf5tUpOHwcO27j-Ojkk8J2KArwtQA1eTsLjXa2zuu9NtDIvaXXX4Hb-JFT6YzFdbf5XWGM7t1PtG1WVezQDBP1zA7gFs33PgCmG6TYuAdZpI-2IMddJZFUJlf3pADGv2S4r6VmPAqH6xqazAdqqOiG7AOShiuOiv_xS5AuBmOh4JREI7CPQVmRxljwQpqv4x4m0yTGLzWBmWh3rRfHJvy04BMr7zjGXSdQUUSrNiQuMO-EDKMIGXNAlqlEi98rHBEeMyNjHc3e8ruk3p2rkUQYqKMz4KNdYMEmEXpc4J1PuWkHCKsQP9brvcrSpU0ac_4WUSeYV1NpnnagN5_EK8zqGocbPdd5MdFR7njMIa9_yHmEJUcFXcQf1AmmIiHXlXQHCVsXChZTzfst_IQaZVTP2tztrYoqKVcFNmOMujkAqzLGhMnOeOsPpwdiEYOls0mWdyAWYUupbz84ndzI6yjbLPBjiXVIHbIX4Rinu6E6KVFTLwPyk-GRt0pA5ZDREjKK8hyTN8T8fOqfBOu9uJwQ9IPATV9EfCVc=w398-h220-no?authuser=0',
    'https://img.freepik.com/free-vector/modern-website-banner-template-with-abstract-shapes_1361-3311.jpg?w=2000'
  ];
  int current = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        CarouselSlider(
          items: images
              .map(
                (image) => Container(
                  width: MediaQuery.of(context).size.width,
                  height: _height,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image.network(image),
                  ),
                ),
              )
              .toList(),
          options: CarouselOptions(
            height: _height,
            autoPlay: true,
            viewportFraction: 1,
            onPageChanged: (index, _) {
              setState(() {
                current = index;
              });
            },
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: images.map(
                (image) {
                  int index = images.indexOf(image);
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
                      color: current == index
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
