import 'package:flutter/material.dart';

class AppSpacing {
  AppSpacing._();

  static const double xxs = 2.0;
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;
  static const double huge = 40.0;
  static const double massive = 48.0;
  static const double enormous = 64.0;

  static const double touchTargetMinimum = 44.0;
  static const double touchTargetLarge = 48.0;

  static const EdgeInsets cardPadding = EdgeInsets.all(lg);
  static const EdgeInsets cardContentPadding = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: md,
  );
  static const EdgeInsets cardMargin = EdgeInsets.all(sm);

  static const EdgeInsets buttonPaddingHorizontal = EdgeInsets.symmetric(
    horizontal: xl,
  );
  static const EdgeInsets buttonPaddingVertical = EdgeInsets.symmetric(
    vertical: md,
  );
  static const EdgeInsets buttonPaddingAll = EdgeInsets.symmetric(
    horizontal: xl,
    vertical: md,
  );
  static const double buttonMinimumHeight = touchTargetMinimum;

  static const EdgeInsets pagePadding = EdgeInsets.all(lg);
  static const EdgeInsets pageHorizontalPadding = EdgeInsets.symmetric(
    horizontal: lg,
  );
  static const EdgeInsets pageVerticalPadding = EdgeInsets.symmetric(
    vertical: lg,
  );

  static const EdgeInsets sectionSpacing = EdgeInsets.symmetric(vertical: xxl);
  static const EdgeInsets sectionHorizontalSpacing = EdgeInsets.symmetric(
    horizontal: lg,
  );
  static const EdgeInsets sectionContentSpacing = EdgeInsets.only(bottom: lg);

  static const EdgeInsets listItemPadding = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: md,
  );
  static const EdgeInsets listItemMargin = EdgeInsets.symmetric(vertical: xs);
  static const double listItemMinimumHeight = touchTargetMinimum;

  static const EdgeInsets dialogPadding = EdgeInsets.all(xxl);
  static const EdgeInsets dialogActionsPadding = EdgeInsets.only(
    top: lg,
    left: lg,
    right: lg,
    bottom: md,
  );
  static const EdgeInsets dialogTitlePadding = EdgeInsets.only(bottom: md);

  static const EdgeInsets inputPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: md,
  );
  static const EdgeInsets inputContentPadding = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: lg,
  );
  static const EdgeInsets inputLabelPadding = EdgeInsets.only(bottom: xs);
  static const EdgeInsets inputErrorPadding = EdgeInsets.only(top: xs);

  static const EdgeInsets appBarPadding = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets appBarContentPadding = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: md,
  );

  static const EdgeInsets bottomNavigationPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: xs,
  );
  static const EdgeInsets bottomNavigationItemPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: xs,
  );
  static const double bottomNavigationHeight = touchTargetMinimum + xl;

  static const EdgeInsets fabPadding = EdgeInsets.all(md);
  static const double fabMinimumSize = touchTargetLarge;

  static const EdgeInsets chipPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: xs,
  );
  static const EdgeInsets chipContentPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: xs,
  );
  static const double chipMinimumHeight = touchTargetMinimum;

  static const EdgeInsets iconButtonPadding = EdgeInsets.all(md);
  static const double iconButtonMinimumSize = touchTargetMinimum;

  static const EdgeInsets tabPadding = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: md,
  );
  static const EdgeInsets tabContentPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: xs,
  );

  static const EdgeInsets dividerMargin = EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets dividerPadding = EdgeInsets.symmetric(horizontal: lg);

  static const EdgeInsets screenSafeAreaPadding = EdgeInsets.symmetric(
    horizontal: lg,
  );
  static const EdgeInsets screenContentPadding = EdgeInsets.all(lg);
  static const EdgeInsets screenHorizontalPadding = EdgeInsets.symmetric(
    horizontal: lg,
  );
  static const EdgeInsets screenVerticalPadding = EdgeInsets.symmetric(
    vertical: lg,
  );

  static const EdgeInsets modalPadding = EdgeInsets.all(xxl);
  static const EdgeInsets modalContentPadding = EdgeInsets.symmetric(
    horizontal: xxl,
    vertical: lg,
  );

  static const EdgeInsets tooltipPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: xs,
  );
  static const EdgeInsets tooltipContentPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: xs,
  );

  static const EdgeInsets scaffoldPadding = EdgeInsets.zero;
  static const EdgeInsets scaffoldBodyPadding = EdgeInsets.all(lg);

  static const EdgeInsetsGeometry zero = EdgeInsets.zero;

  static EdgeInsets getResponsivePadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return const EdgeInsets.symmetric(horizontal: md, vertical: lg);
    } else if (width < 1200) {
      return const EdgeInsets.symmetric(horizontal: lg, vertical: xxl);
    } else {
      return const EdgeInsets.symmetric(horizontal: xxl, vertical: xxxl);
    }
  }

  static double getResponsiveSpacing(BuildContext context, {double base = md}) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return base * 0.75;
    } else if (width < 1200) {
      return base;
    } else {
      return base * 1.25;
    }
  }

  static EdgeInsets getResponsiveMargin(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return const EdgeInsets.all(sm);
    } else if (width < 1200) {
      return const EdgeInsets.all(md);
    } else {
      return const EdgeInsets.all(lg);
    }
  }

  static SizedBox get horizontalSpaceTiny => const SizedBox(width: xs);
  static SizedBox get horizontalSpaceSmall => const SizedBox(width: sm);
  static SizedBox get horizontalSpaceMedium => const SizedBox(width: md);
  static SizedBox get horizontalSpaceLarge => const SizedBox(width: lg);
  static SizedBox get horizontalSpaceExtraLarge => const SizedBox(width: xxl);

  static SizedBox get verticalSpaceTiny => const SizedBox(height: xs);
  static SizedBox get verticalSpaceSmall => const SizedBox(height: sm);
  static SizedBox get verticalSpaceMedium => const SizedBox(height: md);
  static SizedBox get verticalSpaceLarge => const SizedBox(height: lg);
  static SizedBox get verticalSpaceExtraLarge => const SizedBox(height: xxl);

  static SizedBox horizontalSpace(double width) => SizedBox(width: width);
  static SizedBox verticalSpace(double height) => SizedBox(height: height);
}
