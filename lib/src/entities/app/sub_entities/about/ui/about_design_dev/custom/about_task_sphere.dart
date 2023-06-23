part of '../about_design_dev_screen.dart';

class _AboutTaskSphere extends StatelessWidget {
  const _AboutTaskSphere({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About TaskSphere',
            style: context.primaryTypography.title.small.asBold
                .withColor(context.neutralColors.$700),
          ),
          16.boxHeight,
          Text(
            TaskSphereInfo.aboutTaskSphere,
            style: context.secondaryTypography.paragraph.medium.asRegular
                .withColor(context.neutralColors.$800),
          ),
          200.boxHeight,
        ],
      ),
    );
  }
}
