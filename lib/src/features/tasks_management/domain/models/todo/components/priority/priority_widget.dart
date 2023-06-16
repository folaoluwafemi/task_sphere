part of 'priority.dart';

class _PriorityWidget extends StatelessWidget {
  final Priority priority;
  final bool showText;
  final double? size;

  const _PriorityWidget.small({
    Key? key,
    required this.priority,
  })  : size = null,
        showText = false,
        super(key: key);

  const _PriorityWidget.customSize({
    Key? key,
    required this.priority,
    required this.size,
  })  : showText = false,
        super(key: key);

  const _PriorityWidget.large({
    Key? key,
    required this.priority,
  })  : showText = true,
        size = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final double size_ = size ?? (showText ? 20.l : 16.l);
    if (!showText) {
      return SizedBox.square(
        dimension: size_,
        child: SvgPicture.asset(priority.vectorAsset!),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox.square(
          dimension: size_,
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
