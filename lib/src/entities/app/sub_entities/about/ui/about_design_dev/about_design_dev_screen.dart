import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:task_sphere/src/entities/app/app_barrel.dart';
import 'package:task_sphere/src/entities/todo/todo_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'custom/about_design_and_dev_view.dart';

part 'custom/about_task_sphere.dart';

part 'custom/back_button.dart';

part 'custom/contact_card.dart';

part 'custom/contact_widget.dart';

part 'custom/footer_bar.dart';

part 'custom/stacked_text.dart';

class AboutDesignAndDev extends StatelessWidget {
  const AboutDesignAndDev({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: context.palette.bgAccent,
      ),
      backgroundColor: context.bgColors.$100,
      body: Stack(
        children: [
          CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverStack(
                children: [
                  const _AboutDesign$DevView(),
                  SliverPositioned(
                    top: 64.h,
                    left: 166.w,
                    child: SizedBox.square(
                      dimension: 366.l,
                      child: Image.asset(
                        Assets.aboutDevelopmentIllustration,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: _FooterBar(),
          ),
        ],
      ),
    );
  }
}
