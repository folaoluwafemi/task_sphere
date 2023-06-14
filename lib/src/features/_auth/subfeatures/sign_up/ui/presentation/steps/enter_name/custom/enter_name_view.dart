part of '../enter_name_screen.dart';

class _EnterNameView extends StatefulWidget {
  const _EnterNameView({Key? key}) : super(key: key);

  @override
  State<_EnterNameView> createState() => _EnterNameViewState();
}

class _EnterNameViewState extends State<_EnterNameView> {
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
            text: 'Welcome, Enjoy better productivity 🚀',
          );
          context.goNamed(AppRoute.home.name);
        }

        if (current.error == null) return;
        AlertType.error.show(context, text: current.error?.message ?? '');
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(18.w, 139.h, 18.w, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 134.3.w,
              height: 133.87.h,
              child: Image.asset(
                Assets.signUpSuccessIllustration,
                fit: BoxFit.contain,
              ),
            ),
            32.boxHeight,
            Text(
              'You’re in!',
              style: context.primaryTypography.title.large,
            ),
            12.boxHeight,
            Text(
              'Welcome to TaskSphere. We hope you find our app valuable to your productivity.',
              style: context.secondaryTypography.paragraph.medium.asRegular,
            ),
            42.boxHeight,
            Text(
              'What should we call you?',
              style: context.secondaryTypography.paragraph.large.asMedium
                  .withColor(
                context.neutralColors.$700,
              ),
            ),
            8.boxHeight,
            InputFormField(
              hintText: 'Firstname Lastname',
              prefixIconBuilder: (context, color) => CustomColorFilter(
                color: color,
                child: SvgPicture.asset(
                  VectorAssets.profileFilled,
                ),
              ),
              onChanged: (value) {
                name = value;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null ||
                    (value.words.length != 2 &&
                        value.words.every((element) {
                          return element.isNotEmpty;
                        }))) {
                  changeFieldsValidated(false);
                  return null;
                }
                changeFieldsValidated(true);
                return null;
              },
            ),
            32.boxHeight,
            VanillaBuilder<SignUpVanilla, SignUpState>(
              buildWhen: (previous, current) =>
                  previous?.loading != current.loading,
              builder: (context, state) => ValueListenableBuilder<bool>(
                valueListenable: fieldValidated,
                builder: (_, validated, __) => LargeButton(
                  width: 354.w,
                  color: context.palette.primary,
                  onPressed: (state.loading || !validated)
                      ? null
                      : onProceedToHomePagePressed,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    child: Text(
                      'Proceed to my homepage',
                      style: context.buttonTextStyle.asMedium.withColor(
                        context.bgColors.$50,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            151.13.boxHeight,
            VanillaBuilder<SignUpVanilla, SignUpState>(
              buildWhen: (previous, current) =>
                  previous?.loading != current.loading,
              builder: (context, state) {
                if (!state.loading) return const SizedBox.shrink();
                return Center(
                  child: Column(
                    children: [
                      LoaderWidget(
                        color: context.palette.primary,
                      ),
                      12.boxHeight,
                      Text(
                        'Hold on...',
                        style: context.secondaryTypography.paragraph.large,
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  final ValueNotifier<bool> fieldValidated = ValueNotifier<bool>(false);

  void changeFieldsValidated(bool value) {
    if (value ^ fieldValidated.value) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        fieldValidated.value = value;
      });
    }
  }

  void onProceedToHomePagePressed() {
    FocusScope.of(context).unfocus();
    context.read<SignUpVanilla>().updateName(
          firstname: name.words.first,
          lastname: name.words.last,
        );
  }

  String name = '';

  @override
  void dispose() {
    fieldValidated.dispose();
    super.dispose();
  }
}
