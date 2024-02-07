import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:task_sphere/src/entities/app/app_barrel.dart';
import 'package:task_sphere/src/features/_auth/auth_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';
import 'package:vanilla_state/vanilla_state.dart';

part 'custom/login_or_load_widget.dart';

part 'custom/login_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ScrollController controller = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedVanilla<LoginVanilla>(
      createNotifier: () => LoginVanilla(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: context.bgColors.$50,
        body: CustomScrollView(
          slivers: [
            SliverStack(
              children: [
                SliverPositioned(
                  top: -134.h,
                  left: -64.w,
                  child: SizedBox(
                    width: 313.w,
                    height: 347.h,
                    child: SvgDecorator(
                      color: context.neutralColors.$200,
                      child: SvgPicture.asset(
                        VectorAssets.spadesLines,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(bottom: context.bottomScreenPadding),
                  sliver: _LoginView(
                    controller: controller,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 18.w, top: 65.h),
                      child: VanillaBuilder<LoginVanilla, LoginState>(
                        buildWhen: (previous, current) =>
                            previous?.loading != current.loading,
                        builder: (context, state) {
                          return BackButton(
                            filledColor: true,
                            onPressed:
                                state.loading ? null : () => context.pop(),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
