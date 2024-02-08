import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:task_sphere/src/entities/app/app_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

part 'custom/about_dev_button.dart';

part 'custom/openly_cooking_container.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.bgColors.$100,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: context.bgColors.$100,
      ),
      body: CustomScrollView(
        slivers: [
          MultiSliver(
            children: [
              14.sliverBoxHeight,
              SliverPinnedHeader(
                child: Container(
                  color: context.bgColors.$100,
                  padding: EdgeInsets.only(top: 14.h, bottom: 10.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      6.boxWidth,
                      IconButton(
                        onPressed: context.pop,
                        icon: SvgDecorator.square(
                          dimension: 24.l,
                          color: context.neutralColors.$600,
                          child: SvgPicture.asset(
                            VectorAssets.arrowLeft,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'About app',
                        style: context.primaryTypography.title.small.asBold,
                      ),
                      const Spacer(),
                      48.boxWidth,
                    ],
                  ),
                ),
              ),
              54.sliverBoxHeight,
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const _OpenlyCookingContainer(),
                    ...AboutButton.values.map(
                      (detail) => Padding(
                        padding: EdgeInsets.only(top: 12.h),
                        child: AboutDevButton(
                          onPressed: () => detail.action(context),
                          aboutButtonDetail: detail,
                        ),
                      ),
                    ),
                    24.boxHeight,
                    Text(
                      'Version 2.1.0',
                      style: context.secondaryTypography.paragraph.small
                          .withColor(context.neutralColors.$600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
