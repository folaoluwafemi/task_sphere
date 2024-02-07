import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:task_sphere/src/entities/entities_barrel.dart';
import 'package:task_sphere/src/features/_auth/auth_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';
import 'package:vanilla_state/vanilla_state.dart';

part 'custom/enter_name_view.dart';

class EnterNameScreen extends StatelessWidget {
  final bool redirect;

  const EnterNameScreen({
    Key? key,
    required this.redirect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !redirect,
      child: InheritedVanilla<SignUpVanilla>(
        createNotifier: () => SignUpVanilla(),
        child: Scaffold(
          body: Stack(
            children: [
              const _EnterNameView(),
              if (!redirect)
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
      ),
    );
  }
}
