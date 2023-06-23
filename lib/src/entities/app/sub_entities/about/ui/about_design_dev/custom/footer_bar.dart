part of '../about_design_dev_screen.dart';

class _FooterBar extends StatelessWidget {
  const _FooterBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          color: context.bgColors.$100.withOpacity(0.12),
          width: context.screenWidth,
          height: context.bottomScreenPadding,
        ),
        Container(
          color: context.bgColors.$100.withOpacity(0.12),
          width: context.screenWidth,
          height: context.bottomScreenPadding,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 6,
                sigmaY: 6,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
