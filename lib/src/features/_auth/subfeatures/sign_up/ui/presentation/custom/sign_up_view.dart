part of '../sign_up_screen.dart';

class _SignUpView extends StatefulWidget {
  const _SignUpView({Key? key}) : super(key: key);

  @override
  State<_SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<_SignUpView> {
  @override
  Widget build(BuildContext context) {
    return VanillaListener<SignUpVanilla, SignUpState>(
      listenWhen: (previous, current) =>
          previous?.error != current.error ||
          previous?.success != current.success,
      listener: (previous, current) {
        if (current.success) {
          AlertType.success.show(
            context,
            text: 'Account created successfully!!',
          );
          context.pop();
        }

        if (current.error == null) return;
        AlertType.error.show(context, text: current.error?.message ?? '');
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(18.w, 290.h, 18.w, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create an account',
              style: context.primaryTypography.title.large,
            ),
            6.boxHeight,
            Text(
              'Join the productivity clan on TaskSphere',
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
              prefixIconBuilder: (_, color) => CustomColorFilter(
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
              prefixIconBuilder: (_, color) => CustomColorFilter(
                color: color,
                child: SvgPicture.asset(
                  VectorAssets.password,
                ),
              ),
            ),
            48.boxHeight,
            ValueListenableBuilder<bool>(
              valueListenable: fieldsValidated,
              builder: (_, validated, __) {
                return VanillaBuilder<SignUpVanilla, SignUpState>(
                  buildWhen: (previous, current) =>
                      previous?.loading != current.loading,
                  builder: (context, state) {
                    return LargeButton(
                      color: context.palette.primary,
                      onPressed: (state.loading || !validated)
                          ? null
                          : onJoinButtonPressed,
                      width: 354.w,
                      height: 50.h,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox.square(
                            dimension: 24.l,
                            child: SvgPicture.asset(
                              VectorAssets.add,
                            ),
                          ),
                          6.boxWidth,
                          Text(
                            'Join TaskSphere',
                            style: context.buttonTextStyle.withColor(
                              context.bgColors.$50,
                            ),
                          ),
                        ],
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

  void onJoinButtonPressed() {
    // context.read<SignUpVanilla>().signUp(
    //       email: email,
    //       password: password,
    //     );

    AlertType.error.show(
      context,
      // text: 'Account created asldkja sd flkjadsfklajkdf adsfljk  alsdjf adslfkjasd flajdsf akldsfjasd flajdsf asdlfkjasd fajsdflajsd fasdljfa dsasdf aldskjfasd adskjf sdfljasd flajdf asldkjfa sdlfkjsd fsldjfa sdfaljdsfa dlsfasdlfjasdlaj flhj asdflajd successfully!',
      text: 'asdfas asdfasd asd',
    );
  }
}
