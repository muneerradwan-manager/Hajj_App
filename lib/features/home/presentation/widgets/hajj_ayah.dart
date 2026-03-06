import 'dart:math';

import 'package:flutter/material.dart';

import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:bawabatelhajj/core/localization/app_localizations_setup.dart';

import '../../../../shared/widgets/custom_container.dart';
import '../../../../shared/widgets/custom_text.dart';

class HajjAyah extends StatefulWidget {
  const HajjAyah({super.key});

  @override
  State<HajjAyah> createState() => _HajjAyahState();
}

class _HajjAyahState extends State<HajjAyah> {
  late final _HajjAyahKeys _ayah;

  @override
  void initState() {
    super.initState();
    _ayah = _hajjAyahs[Random().nextInt(_hajjAyahs.length)];
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return CustomContainer(
      gradientColors: [cs.surfaceDim, cs.brandGold],
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 10,
        children: [
          CustomText(
            '﴿ ${_ayah.textKey.tr(context)} ﴾',
            type: CustomTextType.bodyLarge,
            color: CustomTextColor.red,
            textAlign: TextAlign.center,
            translate: false,
          ),
          CustomText(
            _ayah.sourceKey.tr(context),
            type: CustomTextType.labelLarge,
            color: CustomTextColor.lightRed,
            textAlign: TextAlign.center,
            translate: false,
          ),
        ],
      ),
    );
  }
}

class _HajjAyahKeys {
  const _HajjAyahKeys(this.textKey, this.sourceKey);
  final String textKey;
  final String sourceKey;
}

const _hajjAyahs = <_HajjAyahKeys>[
  _HajjAyahKeys('home.ayahs.ayah_01.text', 'home.ayahs.ayah_01.source'),
  _HajjAyahKeys('home.ayahs.ayah_02.text', 'home.ayahs.ayah_02.source'),
  _HajjAyahKeys('home.ayahs.ayah_03.text', 'home.ayahs.ayah_03.source'),
  _HajjAyahKeys('home.ayahs.ayah_04.text', 'home.ayahs.ayah_04.source'),
  _HajjAyahKeys('home.ayahs.ayah_05.text', 'home.ayahs.ayah_05.source'),
  _HajjAyahKeys('home.ayahs.ayah_06.text', 'home.ayahs.ayah_06.source'),
  _HajjAyahKeys('home.ayahs.ayah_07.text', 'home.ayahs.ayah_07.source'),
  _HajjAyahKeys('home.ayahs.ayah_08.text', 'home.ayahs.ayah_08.source'),
  _HajjAyahKeys('home.ayahs.ayah_09.text', 'home.ayahs.ayah_09.source'),
  _HajjAyahKeys('home.ayahs.ayah_10.text', 'home.ayahs.ayah_10.source'),
  _HajjAyahKeys('home.ayahs.ayah_11.text', 'home.ayahs.ayah_11.source'),
  _HajjAyahKeys('home.ayahs.ayah_12.text', 'home.ayahs.ayah_12.source'),
  _HajjAyahKeys('home.ayahs.ayah_13.text', 'home.ayahs.ayah_13.source'),
  _HajjAyahKeys('home.ayahs.ayah_14.text', 'home.ayahs.ayah_14.source'),
  _HajjAyahKeys('home.ayahs.ayah_15.text', 'home.ayahs.ayah_15.source'),
  _HajjAyahKeys('home.ayahs.ayah_16.text', 'home.ayahs.ayah_16.source'),
  _HajjAyahKeys('home.ayahs.ayah_17.text', 'home.ayahs.ayah_17.source'),
  _HajjAyahKeys('home.ayahs.ayah_18.text', 'home.ayahs.ayah_18.source'),
  _HajjAyahKeys('home.ayahs.ayah_19.text', 'home.ayahs.ayah_19.source'),
  _HajjAyahKeys('home.ayahs.ayah_20.text', 'home.ayahs.ayah_20.source'),
  _HajjAyahKeys('home.ayahs.ayah_21.text', 'home.ayahs.ayah_21.source'),
  _HajjAyahKeys('home.ayahs.ayah_22.text', 'home.ayahs.ayah_22.source'),
  _HajjAyahKeys('home.ayahs.ayah_23.text', 'home.ayahs.ayah_23.source'),
  _HajjAyahKeys('home.ayahs.ayah_24.text', 'home.ayahs.ayah_24.source'),
  _HajjAyahKeys('home.ayahs.ayah_25.text', 'home.ayahs.ayah_25.source'),
];
