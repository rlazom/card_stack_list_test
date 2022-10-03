import 'extensions.dart';
import 'package:flutter/material.dart' show Color;

/// URL ------------------------------------------------------------------------
class R {
  R._();
  static RkColors get colors => const RkColors._();
  static RkAssets get assets => const RkAssets._();
}
/// ----------------------------------------------------------------------------

/// Colors ---------------------------------------------------------------------
class RkColors {
  const RkColors._();
  // RkColorPrimary get primaries => const RkColorPrimary._();
  // RkColorAccent get accents => const RkColorAccent._();
  // RkColorNeutral get neutrals => const RkColorNeutral._();
  // RkColorSemantic get semantics => const RkColorSemantic._();

  Color get primary => '#03A062'.hexToColor;
  Color get background => '#0B0F0F'.hexToColor;
  Color get bankMetropolitanoGrey => '#d3d5c8'.hexToColor;
  Color get bankMetropolitanoGreen => '#66d403'.hexToColor;
  // Color get mapDarkBackgroundColor => '#242424'.hexToColor();
  // Color get mapLightBackgroundColor => '#9ec5ef'.hexToColor();
}
// class RkColorPrimary {
//   const RkColorPrimary._();
//   Color get green1 => '#CDECE0'.hexToColor;
//   Color get green2 => '#35B381'.hexToColor;
//   Color get green3 => '#1C9A68'.hexToColor;
//   Color get green4 => '#02804E'.hexToColor;
//   Color get green5 => '#01301D'.hexToColor;
//   Color get green6 => '#00100A'.hexToColor;
//   Color get gray1 => '#B2B2B2'.hexToColor;
//   Color get gray2 => '#7A7A7A'.hexToColor;
//   Color get gray3 => '#6A6A6A'.hexToColor;
//   Color get gray4 => '#575757'.hexToColor;
// }
// class RkColorAccent {
//   const RkColorAccent._();
//   Color get rose1 => '#FC5F9D'.hexToColor;
//   Color get rose2 => '#A00341'.hexToColor;
// }
// class RkColorNeutral {
//   const RkColorNeutral._();
//   Color get gray1 => '#B2B2B2'.hexToColor;
//   Color get gray2 => '#7A7A7A'.hexToColor;
//   Color get gray3 => '#6A6A6A'.hexToColor;
//   Color get gray4 => '#525252'.hexToColor;
// }
// class RkColorSemantic {
//   const RkColorSemantic._();
//   Color get green1 => '#8FF297'.hexToColor;
//   Color get green2 => '#78CC7F'.hexToColor;
//   Color get green3 => '#4B7F50'.hexToColor;
//   Color get green4 => '#3C6640'.hexToColor;
//   Color get red1 => '#F25050'.hexToColor;
//   Color get red2 => '#CC4343'.hexToColor;
//   Color get red3 => '#993232'.hexToColor;
//   Color get red4 => '#662222'.hexToColor;
// }
/// ----------------------------------------------------------------------------



class RkAssets {
  const RkAssets._();
  static const String assetsFolder = 'assets/';
  RkImages get images => const RkImages._();
}
class RkImages {
  const RkImages._();
  static const String assetsPngFolder = 'png/';
  static const String assetsJpegFolder = 'jpeg/';
  static const String assetsSvgFolder = 'svg/';

  String get makkuraLogoJpeg => '${RkAssets.assetsFolder}$assetsJpegFolder''makkura.jpg';
  String get tmdbLogoSvg => '${RkAssets.assetsFolder}$assetsSvgFolder''tmdb_logo.svg';

  /// ---- SPLASH
  String get splashJpeg => makkuraLogoJpeg;

  String get defaultBackdropJpeg => '${RkAssets.assetsFolder}$assetsJpegFolder''default_backdrop.jpg';
}
/// ----------------------------------------------------------------------------
