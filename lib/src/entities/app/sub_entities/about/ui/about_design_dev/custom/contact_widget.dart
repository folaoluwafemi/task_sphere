part of '../about_design_dev_screen.dart';

class _ContactWidget extends StatelessWidget {
  final Priority priority;
  final Contact contact;

  const _ContactWidget({
    Key? key,
    required this.priority,
    required this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: context.neutralColors.$500,
          width: 1.l,
        ),
        borderRadius: Ui.circularBorder(7.l),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgDecorator.square(
            dimension: 18.l,
            color: context.neutralColors.$400,
            child: SvgPicture.asset(contact.vectorAsset),
          ),
          8.boxWidth,
          Expanded(
            child: Text(
              contact.placeholder,
              overflow: TextOverflow.ellipsis,
              strutStyle: const StrutStyle(height: 1.2),
              style: context.primaryTypography.paragraph.small.asRegular
                  .copyWith(decoration: TextDecoration.underline)
                  .withHeight(1.2),
            ),
          ),
          23.boxWidth,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              priority.widgetSmall,
              8.boxWidth,
              Status.todo.widget,
            ],
          ),
        ],
      ),
    );
  }
}
