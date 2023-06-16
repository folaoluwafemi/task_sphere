import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:task_sphere/src/entities/app/ui/components/components_barrel.dart';
import 'package:task_sphere/src/features/_auth/subfeatures/sign_up/ui/state_mgmt/sign_up_vanilla.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'custom/login_or_load_widget.dart';

part 'custom/sign_up_view.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final ScrollController controller = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VanillaNotifierHolder<SignUpVanilla>(
      createNotifier: () =>  SignUpVanilla(),
      child: Scaffold(
        backgroundColor: context.bgColors.$50,
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -134.h,
              left: -64.w,
              child: SizedBox(
                width: 313.w,
                height: 347.h,
                child: CustomColorFilter(
                  color: context.neutralColors.$200,
                  child: SvgPicture.asset(
                    VectorAssets.spadesLines,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SafeArea(
              top: false,
              child: _SignUpView(
                controller: controller,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 18.w, top: 65.h),
              child: VanillaBuilder<SignUpVanilla, SignUpState>(
                buildWhen: (previous, current) =>
                    previous?.loading != current.loading,
                builder: (context, state) {
                  return BackButton(
                    filledColor: true,
                    onPressed: state.loading ? null : () => context.pop(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
