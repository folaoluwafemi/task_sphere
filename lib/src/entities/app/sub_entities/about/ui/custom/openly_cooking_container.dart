part of '../about_app_screen.dart';

class _OpenlyCookingContainer extends StatelessWidget {
  const _OpenlyCookingContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: TaskCardContainer(
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
                'Lorem ipsum dolor sit amet consectetur. Bibendum egestas purus vitae leo vivamus '
                'felis neque. Interdum felis imperdiet nunc viverra in eu vulputate cursus. '
                'Dignissim cras nunc consectetur nunc volutpat. Purus quam ornare justo sed amet.',
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
