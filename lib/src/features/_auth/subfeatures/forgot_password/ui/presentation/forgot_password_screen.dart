import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:task_sphere/src/entities/entities_barrel.dart';
import 'package:task_sphere/src/features/_auth/auth_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';
import 'package:vanilla_state/vanilla_state.dart';

part 'custom/success_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  bool emailValidated = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void updateEmailValidatedStatus(bool value) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        emailValidated = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return InheritedVanilla<ForgotPasswordPresenter>(
      createNotifier: () => ForgotPasswordPresenter(),
      child: Scaffold(
        body: SafeArea(
          child: VanillaBuilder<ForgotPasswordPresenter, ForgotPasswordState>(
            builder: (context, state) {
              return Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        18.boxHeight,
                        BackButton(
                          filledColor: true,
                          onPressed: context.pop,
                        ),
                        if (state.success)
                          const SuccessWidget()
                        else
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              32.boxHeight,
                              Text(
                                'Reset password',
                                style: context
                                    .primaryTypography.title.large.asBold
                                    .withColor(context.neutralColors.$800),
                              ),
                              6.boxHeight,
                              Text(
                                'We understand that life happens, we’ll send a link to your email to reset your password.',
                                style: context
                                    .secondaryTypography.paragraph.medium
                                    .copyWith(
                                  color: context.neutralColors.$700,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              58.boxHeight,
                              Text(
                                'Your email address',
                                style: context
                                    .secondaryTypography.paragraph.large
                                    .withColor(context.neutralColors.$700),
                              ),
                              8.boxHeight,
                              InputFormField(
                                controller: emailController,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (value) {
                                  if (!emailValidated) return;
                                  context
                                      .read<ForgotPasswordPresenter>()
                                      .requestResetEmail(value.trim());
                                },
                                validator: (value) => Validators.emailValidator(
                                  value,
                                  onValidated: updateEmailValidatedStatus,
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.emailAddress,
                                hintText: 'Your email address',
                                prefixIconBuilder: (context, color) {
                                  return SvgDecorator.square(
                                    dimension: 24.l,
                                    color: color,
                                    child: SvgPicture.asset(
                                      VectorAssets.emailIcon,
                                    ),
                                  );
                                },
                              ),
                              32.boxHeight,
                              SmallButton(
                                onPressed: !emailValidated
                                    ? null
                                    : () => context
                                        .read<ForgotPasswordPresenter>()
                                        .requestResetEmail(
                                          emailController.text.trim(),
                                        ),
                                width: 354.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Reset Password',
                                      style: context
                                          .primaryTypography.paragraph.medium
                                          .withColor(
                                        context.neutralColors.$100,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  VanillaListener<ForgotPasswordPresenter, ForgotPasswordState>(
                    listener: (previous, current) {
                      if (current.loading && !(previous?.loading ?? false)) {
                        FocusScope.of(context).unfocus();
                      }
                    },
                    child: (!state.loading)
                        ? const SizedBox.shrink()
                        : Container(
                            alignment: Alignment.bottomCenter,
                            padding: EdgeInsets.only(bottom: 24.l),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                LoaderWidget(
                                  color: context.palette.primary,
                                ),
                                12.boxHeight,
                                Text(
                                  'Hold on...',
                                  style: context.secondaryTypography.paragraph
                                      .large.asMedium
                                      .withColor(context.neutralColors.$800),
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
