import 'package:flutter_svg/flutter_svg.dart';

abstract class PreCacheImages {
  static loadImages() {
    Future.wait([
      precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoderBuilder,
            'assets/images/onboard_images/Onboarding_01.svg'),
        null,
      ),
      precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoderBuilder,
            'assets/images/onboard_images/Onboarding_02.svg'),
        null,
      ),
      precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoderBuilder,
            'assets/images/onboard_images/Onboarding_03.svg'),
        null,
      ),
      precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoderBuilder,
            'assets/images/onboard_images/Onboarding_04.svg'),
        null,
      ),
      precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoderBuilder,
            'assets/images/BG_Parabens.svg'),
        null,
      ),
      precachePicture(
        ExactAssetPicture(
            SvgPicture.svgStringDecoderBuilder, 'assets/images/BG_Gamers.svg'),
        null,
      ),
      precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoderBuilder,
            'assets/images/wallet_images/activated_bg_card.svg'),
        null,
      ),
    ]);
  }
}
