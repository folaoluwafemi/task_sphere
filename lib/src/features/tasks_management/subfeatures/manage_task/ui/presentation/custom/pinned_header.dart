part of '../task_screen.dart';

class _PinnedHeader extends StatefulWidget {
  const _PinnedHeader({Key? key}) : super(key: key);

  @override
  State<_PinnedHeader> createState() => _PinnedHeaderState();
}

class _PinnedHeaderState extends State<_PinnedHeader> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: VanillaBuilder<TaskVanilla, TaskState>(
        buildWhen: (previous, current) {
          return previous?.showAchievement != current.showAchievement;
        },
        builder: (context, state) {
          final bool showAchievement = state.showAchievement;
          return Container(
            color:
                showAchievement ? context.bgColors.$100 : context.bgColors.$50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _CloseButton(),
                const Spacer(),
                if (!showAchievement) ...[
                  const StateText(),
                  const _MoreButton(),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class StateText extends StatelessWidget {
  const StateText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 24.w, top: 12.h),
      child: VanillaBuilder<TaskVanilla, TaskState>(
        builder: (_, state) {
          if (state.error != null) {
            return Text(
              'Error',
              style: context.primaryTypography.paragraph.small.asMedium
                  .withColor(context.alertColors.error),
            );
          }
          if (state.loading) {
            return Text(
              state.loadingText ?? 'Saving...',
              style: context.primaryTypography.paragraph.small.asMedium
                  .withColor(context.neutralColors.$600),
            );
          }

          return Text(
            'Saved',
            style: context.primaryTypography.paragraph.small.asMedium
                .withColor(context.neutralColors.$600),
          );
        },
      ),
    );
  }
}

class _CloseButton extends StatefulWidget {
  const _CloseButton({
    Key? key,
  }) : super(key: key);

  @override
  State<_CloseButton> createState() => _CloseButtonState();
}

class _CloseButtonState extends State<_CloseButton> {
  Future<void> onClose() async {
    final bool isLoading = context.read<TaskVanilla>().state.loading;
    if (isLoading) {
      AlertType.info.show(context, text: 'Wait a sec...😉', delay: 3.seconds);
      return;
    }

    FocusScope.of(context).unfocus();
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: Ui.circularBorder(50),
      onTap: onClose,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 18.w),
        child: SvgDecorator.square(
          dimension: 24.l,
          color: context.neutralColors.$800,
          child: SvgPicture.asset(VectorAssets.cancelFilled),
        ),
      ),
    );
  }
}
