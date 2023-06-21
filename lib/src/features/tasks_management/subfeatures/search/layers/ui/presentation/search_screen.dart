import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:task_sphere/src/entities/entities_barrel.dart';
import 'package:task_sphere/src/features/tasks_management/task_management_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'custom/history_view.dart';

part 'custom/results_view.dart';

part 'custom/search_view.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VanillaNotifierHolder<SearchVanilla>(
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
            child: _SearchView(),
          ),
        ),
      ),
    );
  }
}
