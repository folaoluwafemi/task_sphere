part of '../splash_screen.dart';

class _SplashView extends StatelessWidget {
  const _SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VanillaListener<SplashVanilla, AppRoute>(
      listener: (previous, current) => context.goNamed(current.name),
      child: const Center(
        child: Text(
          'Splash Screen',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
