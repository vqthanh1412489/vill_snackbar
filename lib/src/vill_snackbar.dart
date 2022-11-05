// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vill_snackbar/src/svg_source.dart';

/// Status of the [VillSnackbar].
enum GameSnackbarType {
  /// Success [VillSnackbar].
  success,

  /// Error [VillSnackbar].
  error,

  /// Warning [VillSnackbar].
  warning,

  /// Help [VillSnackbar].
  help
}

/// {@template bi_snackbar}
/// Show snackbar lib
/// {@endtemplate}
class VillSnackbar {
  /// {@macro bi_snackbar}
  const VillSnackbar();

  /// Show snackbar
  static void showSnackBar({
    required BuildContext context,
    required String title,
    required String message,
    required GameSnackbarType type,
  }) {
    /// Color default for snackbar
    var backgroundColor = const Color(0xFFC37602);
    var iconColor = const Color(0xFFFFB446);
    var svgSource = SvgSources.close;

    switch (type) {
      case GameSnackbarType.success:
        backgroundColor = const Color(0xFF76BF4C);
        iconColor = const Color(0xFF055816);
        svgSource = SvgSources.chat;
        break;
      case GameSnackbarType.error:
        backgroundColor = const Color(0xFFF64B3C);
        iconColor = const Color(0xFFC81912);
        svgSource = SvgSources.close;
        break;
      case GameSnackbarType.warning:
        backgroundColor = const Color(0xFFFFB446);
        iconColor = const Color(0xFFC37602);
        svgSource = SvgSources.warning;
        break;
      case GameSnackbarType.help:
        backgroundColor = const Color(0xFF56B6E4);
        iconColor = const Color(0xFF1474BC);
        svgSource = SvgSources.help;
        break;
    }

    final Widget content = Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 4,
                offset: const Offset(0, 4), // changes position of shadow
              ),
            ],
          ),
          constraints: const BoxConstraints(
            minHeight: 80,
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 56,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Alata',
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      message,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                        fontFamily: 'Alata',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20)),
            child: SvgPicture.string(
              SvgSources.bubbles,
              width: 42,
              color: iconColor,
            ),
          ),
        ),
        Positioned(
          top: -16,
          left: 16,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.string(
                SvgSources.chat,
                width: 36,
                color: iconColor,
              ),
              Positioned(
                child: SvgPicture.string(
                  svgSource,
                  width: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        // Positioned(
        //     top: 5,
        //     right: 5,
        //     child: InkWell(
        //       onTap: () {
        //         debugPrint('aa');
        //         OverlaySupportEntry.of(Get.context!)!.dismiss();
        //       },
        //       child: Container(
        //         width: 40,
        //         height: 40,
        //         padding: const EdgeInsets.all(12),
        //         color: Colors.transparent,
        //         child: SvgPicture.string(
        //           SvgSources.close,
        //           width: 8,
        //           color: Colors.white,
        //         ),
        //       ),
        //     )),
      ],
    );

    Get.showSnackbar(
      GetSnackBar(
        messageText: content,
        borderRadius: 20,
        backgroundColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 500),
        duration: const Duration(seconds: 3),
        forwardAnimationCurve: Curves.bounceIn,
        reverseAnimationCurve: Curves.easeIn,
        shouldIconPulse: false,
      ),
    );
  }
}
