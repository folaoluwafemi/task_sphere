part of '../task_screen.dart';

class _PinnedHeader extends StatelessWidget {
  const _PinnedHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CloseButton(),
        Spacer(),
        StateText(),
      ],
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
              'Saving...',
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
    final bool isEmpty = await context.read<TaskVanilla>().deleteEmptyTask();
    if (!mounted) return;
    if (!isEmpty) context.read<TaskVanilla>().save();
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
