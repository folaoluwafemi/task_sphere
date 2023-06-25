part of '../task_screen.dart';

class _TaskAchievement extends StatelessWidget {
  const _TaskAchievement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight,
      child: Stack(
        children: [
          Builder(
            builder: (context) {
              return SafeArea(
                child: SizedBox(
                  height: context.screenHeight,
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(top: 126.h),
                        child: SizedBox.square(
                          dimension: 346.m,
                          child: Image.asset(
                            Assets.taskAchievement,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(top: 414.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'You’re One Step Ahead',
                              style: context
                                  .primaryTypography.title.large.asBold
                                  .withColor(context.palette.secondary),
                            ),
                            17.boxHeight,
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgDecorator.square(
                                  dimension: 20.l,
                                  color: context.neutralColors.$600,
                                  child:
                                      SvgPicture.asset(VectorAssets.tickSquare),
                                ),
                                6.boxWidth,
                                Text(
                                  'Task marked as completed',
                                  style: context.primaryTypography.paragraph
                                      .medium.asRegular
                                      .withColor(context.neutralColors.$700),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 268.h,
              width: 12.w,
              child: Spade.half(
                color: context.palette.primary,
                orientation: SpadeOrientation.vertical,
                stemLength: 268.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
