part of '../home_screen.dart';

class EmptyTasksWidget extends StatelessWidget {
  const EmptyTasksWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          48.boxHeight,
          SvgDecorator.square(
            dimension: 163.l,
            color: context.neutralColors.$400,
            child: SvgPicture.asset(
              VectorAssets.noTasksGhost,
            ),
          ),
          17.boxHeight,
          Text(
            'You do not have any tasks yet!!',
            textAlign: TextAlign.center,
            style: context.primaryTypography.title.small.asBold,
          ),
          12.boxHeight,
          Text(
            'Get started on your journey of productivity',
            textAlign: TextAlign.center,
            style: context.secondaryTypography.paragraph.medium.asRegular
                .withColor(context.neutralColors.$600),
          ),
        ],
      ),
    );
  }
}
