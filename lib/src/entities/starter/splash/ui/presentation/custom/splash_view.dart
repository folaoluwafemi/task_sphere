part of '../splash_screen.dart';

class _SplashView extends StatelessWidget {
  const _SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VanillaListener<SplashVanilla, AppRoute>(
      listener: (previous, current) => context.goNamed(current.name),
      child: Stack(
        children: [
          Center(
            child: SizedBox.square(
              dimension: 80.l,
              child: SvgPicture.asset(
                VectorAssets.logo,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 313.h,
              width: 12,
              child: Spade.half(
                orientation: SpadeOrientation.vertical,
                color: context.neutralColors.$300,
                stemLength: 313.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
