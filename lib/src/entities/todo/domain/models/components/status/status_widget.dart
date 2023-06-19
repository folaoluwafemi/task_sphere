part of 'status.dart';

class _StatusWidget extends StatelessWidget {
  final Status status;

  const _StatusWidget({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.neutralColors.$800,
        borderRadius: BorderRadius.circular(4.l),
      ),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgDecorator.square(
            dimension: 10.l,
            color: context.bgColors.$50,
            child: SvgPicture.asset(
              status.vectorAsset,
            ),
          ),
          4.boxWidth,
          Text(
            status.text,
            style: context.secondaryTypography.caption.regular.copyWith(
              color: context.bgColors.$50,
            ),
          ),
        ],
      ),
    );
  }
}
