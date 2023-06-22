part of '../about_app_screen.dart';

class _OpenlyCookingContainer extends StatelessWidget {
  const _OpenlyCookingContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: TaskCardContainer(
        gutterWidth: 59.w,
        gutterThickness: 6.h,
        child: Container(
          padding: EdgeInsets.fromLTRB(24.w, 32.h, 24.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 84.w,
                height: 68.h,
                child: Image.asset(
                  Assets.openSourced,
                  fit: BoxFit.contain,
                ),
              ),
              10.boxHeight,
              Text(
                'Openly cooking!',
                style: context.primaryTypography.title.large
                    .withColor(context.palette.secondary),
              ),
              10.boxHeight,
              Text(
                'TaskSphere is proudly open source.',
                style: context.primaryTypography.paragraph.small
                    .withColor(context.palette.primary),
              ),
              24.boxHeight,
              //TODO: replace content
              Text(
                TaskSphereInfo.weAreOpenSourced,
                style: context.secondaryTypography.paragraph.medium.asRegular
                    .withColor(context.neutralColors.$800),
              ),
            ],
          ),
        ),
      ),
    );
  }
}