part of 'priority.dart';

class _PriorityWidget extends StatelessWidget {
  final Priority priority;
  final bool showText;

  const _PriorityWidget.small({
    Key? key,
    required this.priority,
  })  : showText = false,
        super(key: key);

  const _PriorityWidget.large({
    Key? key,
    required this.priority,
  })  : showText = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!showText) {
      return SizedBox.square(
        dimension: 16.l,
        child: SvgPicture.asset(priority.vectorAsset!),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox.square(
          dimension: 20.l,
          child: SvgPicture.asset(
            priority.vectorAsset!,
          ),
        ),
        8.boxWidth,
        Text(
          priority.text!,
          style: context.secondaryTypography.paragraph.medium.asRegular,
        ),
      ],
    );
  }
}
