part of '../about_design_dev_screen.dart';

class _ContactWidget extends StatefulWidget {
  final Priority priority;
  final Contact contact;

  const _ContactWidget({
    Key? key,
    required this.priority,
    required this.contact,
  }) : super(key: key);

  @override
  State<_ContactWidget> createState() => _ContactWidgetState();
}

class _ContactWidgetState extends State<_ContactWidget> {
  void catchLaunchError(String message) {
    if (!mounted) return;
    AlertType.error.show(context, text: message);
  }

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () => widget.contact.launchUrl(catchLaunchError),
      highlightColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: Ui.circularBorder(7.l),
        side: BorderSide(
          color: context.neutralColors.$400,
          width: 1.l,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgDecorator.square(
            dimension: 18.l,
            color: context.neutralColors.$400,
            child: SvgPicture.asset(widget.contact.vectorAsset),
          ),
          8.boxWidth,
          Expanded(
            child: Text(
              widget.contact.placeholder,
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
              widget.priority.widgetSmall,
              8.boxWidth,
              Status.todo.widget,
            ],
          ),
        ],
      ),
    );
  }
}
