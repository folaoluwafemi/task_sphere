part of '../login_screen.dart';

class _LoginView extends StatefulWidget {
  final ScrollController controller;

  const _LoginView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  @override
  Widget build(BuildContext context) {
    return VanillaListener<LoginVanilla, LoginState>(
      listenWhen: (previous, current) =>
          previous?.error != current.error ||
          previous?.success != current.success,
      listener: (previous, current) {
        if (current.success) {
          AlertType.success.show(
            context,
            text: 'Logged in successfully!!',
          );
          context.goNamed(AppRoute.home.name);
        }

        if (current.error == null) return;
        AlertType.error.show(context, text: current.error?.message ?? '');
      },
      child: SliverPadding(
        padding: EdgeInsets.fromLTRB(18.w, 137.h, 18.w, 0),
        sliver: SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox.square(
                dimension: 113.h,
                child: Image.asset(
                  Assets.onboardingIllustration,
                ),
              ),
              40.boxHeight,
              Text(
                'Welcome back.',
                style: context.primaryTypography.title.large,
              ),
              6.boxHeight,
              Text(
                'Continue right back from where you stopped.',
                style: context.secondaryTypography.paragraph.medium.asRegular,
              ),
              52.boxHeight,
              Text(
                'Email address',
                style: context.secondaryTypography.paragraph.large.asMedium
                    .withColor(context.neutralColors.$700),
              ),
              8.boxHeight,
              InputFormField(
                hintText: 'Enter your email address',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  email = value;
                },
                validator: (value) => Validators.emailValidator(
                  value,
                  onValidated: (value) {
                    emailValidated = value;
                    checkFieldsValidated();
                  },
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                prefixIconBuilder: (_, color) => SvgDecorator.square(
                  dimension: 24.l,
                  color: color,
                  child: SvgPicture.asset(
                    VectorAssets.mail,
                  ),
                ),
              ),
              32.boxHeight,
              Text(
                'Password',
                style: context.secondaryTypography.paragraph.large.asMedium
                    .withColor(context.neutralColors.$700),
              ),
              8.boxHeight,
              PasswordFormField(
                hintText: 'Your password',
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) {
                  if (!fieldsValidated.value) {
                    return FocusScope.of(context).unfocus();
                  }
                  login();
                },
                onChanged: (value) {
                  password = value;
                },
                validator: (value) => Validators.simpleValidator(
                  value,
                  onValidated: (value) {
                    passwordValidated = value;
                    checkFieldsValidated();
                  },
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                prefixIconBuilder: (_, color) => SvgDecorator.square(
                  dimension: 24.l,
                  color: color,
                  child: SvgPicture.asset(
                    VectorAssets.password,
                  ),
                ),
              ),
              8.boxHeight,
              Align(
                alignment: Alignment.centerRight,
                child: RawMaterialButton(
                  onPressed: () => context.pushNamed(
                    AppRoute.forgotPassword.name,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  constraints: const BoxConstraints.tightForFinite(),
                  child: Text(
                    'Forgot my password',
                    style: context.secondaryTypography.paragraph.medium
                        .withDecoration(TextDecoration.underline),
                  ),
                ),
              ),
              28.boxHeight,
              ValueListenableBuilder<bool>(
                valueListenable: fieldsValidated,
                builder: (_, validated, __) {
                  return VanillaBuilder<LoginVanilla, LoginState>(
                    buildWhen: (previous, current) =>
                        previous?.loading != current.loading,
                    builder: (context, state) {
                      return LargeButton(
                        color: context.palette.primary,
                        onPressed: (state.loading || !validated) ? null : login,
                        width: 354.w,
                        height: 50.h,
                        child: Text(
                          'Login to my account',
                          style: context.buttonTextStyle.withColor(
                            context.bgColors.$50,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const _LoginOrLoadWidget(),
              26.boxHeight,
            ],
          ),
        ),
      ),
    );
  }

  bool emailValidated = false;
  bool passwordValidated = false;

  String email = '';
  String password = '';

  final ValueNotifier<bool> fieldsValidated = ValueNotifier<bool>(false);

  void checkFieldsValidated() {
    final bool value = emailValidated && passwordValidated;
    Future.delayed(
      Duration.zero,
      () {
        if (fieldsValidated.value ^ value) {
          fieldsValidated.value = value;
        }
      },
    );
  }

  void login() {
    FocusScope.of(context).unfocus();
    context.read<LoginVanilla>().login(
          email: email,
          password: password,
        );
  }
}
