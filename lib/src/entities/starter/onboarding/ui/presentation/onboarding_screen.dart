import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_sphere/src/entities/app/ui/components/inputs/input_field.dart';
import 'package:task_sphere/src/entities/app/ui/components/inputs/otp.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final TextEditingController controller =
      TextEditingController(text: 'basdajfa sdfa');

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: context.palette.primary,
      ),
      backgroundColor: context.palette.bgAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            30.boxHeight,
            TextField(controller: controller,),
            10.boxHeight,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.m),
              child: InputField(
                controller: controller,
                hintText: 'Your Email Address',
                palette: context.inputPalette.singleFieldPalette,
                prefixIconBuilder: (context, color) => SvgPicture.asset(
                  VectorAssets.profileFilled,
                  color: color,
                ),
              ),
            ),
            30.boxHeight,
            30.boxHeight,
            Row(
              children: [
                Expanded(
                  child: CodeFields(
                    onChanged: (value) {},
                  ),
                ),
                8.boxWidth,
                Container(
                  color: Colors.black12,
                  child: Text(
                    '  a55 ',
                    style: context.primaryTypography.title.large,
                  ),
                ),
              ],
            ),
            10.boxHeight,
          ],
        ),
      ),
    );
  }
}
