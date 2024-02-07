import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:task_sphere/src/entities/entities_barrel.dart';
import 'package:task_sphere/src/features/tasks_management/task_management_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';
import 'package:vanilla_state/vanilla_state.dart';

part 'custom/search_by_date_button.dart';

part 'custom/search_view.dart';

part 'custom/top_contents.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ViewPadding padding = View.of(context).viewPadding;
    final EdgeInsets viewInsets = MediaQuery.of(context).viewInsets;
    final EdgeInsets viewPadding = MediaQuery.of(context).viewPadding;
    return InheritedVanilla<SearchVanilla>(
      createNotifier: () => SearchVanilla()..initialize(),
      child: VanillaListener<SearchVanilla, SearchState>(
        listenWhen: (previous, current) => previous?.error != current.error,
        listener: (previous, current) {
          if (current.error != null) {
            AlertType.error.show(
              context,
              text: current.error?.message ?? ErrorMessages.unknown,
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            elevation: 0,
            backgroundColor: context.bgColors.$50,
          ),
          backgroundColor: context.bgColors.$100,
          body: const SafeArea(
            top: false,
            bottom: true,
            child: SearchView(),
          ),
        ),
      ),
    );
  }
}
