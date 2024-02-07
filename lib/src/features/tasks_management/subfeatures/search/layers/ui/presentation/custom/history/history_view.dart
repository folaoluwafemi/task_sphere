import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_sphere/src/features/tasks_management/task_management_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';
import 'package:vanilla_state/vanilla_state.dart';

part 'empty_history_view.dart';

part 'history_item_widget.dart';

part 'top_history_prompt_and_action.dart';

class HistoryView extends StatefulWidget {
  final TextEditingController controller;

  const HistoryView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  Future<void> onItemPressed(String query) async {
    FocusScope.of(context).unfocus();
    widget.controller.text = query;
    await context.read<SearchVanilla>().searchFor(query);
    if (!mounted) return;
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return VanillaBuilder<SearchVanilla, SearchState>(
      buildWhen: (previous, current) =>
          previous?.history != current.history ||
          previous?.history.length != current.history.length,
      builder: (context, state) {
        if (state.history.isEmpty) return const _EmptyHistoryView();
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  74.boxHeight,
                  const _TopHistoryPromptAndAction(),
                  24.boxHeight,
                ],
              ),
            ),
            6.sliverBoxHeight,
            SliverList.separated(
              itemCount: state.history.length,
              separatorBuilder: (context, index) => 12.boxHeight,
              itemBuilder: (context, index) => _HistoryItemWidget(
                history: state.history[index],
                controller: widget.controller,
                onPressed: () => onItemPressed(state.history[index]),
              ),
            ),
            6.sliverBoxHeight,
          ],
        );
      },
    );
  }
}
