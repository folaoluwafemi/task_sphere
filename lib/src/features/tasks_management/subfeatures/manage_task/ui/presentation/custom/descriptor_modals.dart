part of '../task_screen.dart';

class _CompletionLevelModal extends StatefulWidget {
  final Status initialStatus;
  final ValueChanged<Status> onChanged;

  const _CompletionLevelModal({
    Key? key,
    required this.initialStatus,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<_CompletionLevelModal> createState() => _CompletionLevelModalState();
}

class _CompletionLevelModalState extends State<_CompletionLevelModal> {
  late final ValueNotifier<Status> statusNotifier =
      ValueNotifier(widget.initialStatus);

  void changeStatus(Status status) {
    if (status == statusNotifier.value) return;
    statusNotifier.value = status;
    widget.onChanged(status);
  }

  @override
  Widget build(BuildContext context) {
    return ModalCard(
      gutterHeight: 44.02.h,
      child: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 16.h),
        child: ValueListenableBuilder<Status>(
          valueListenable: statusNotifier,
          builder: (_, currentStatus, __) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ASSIGN COMPLETION LEVEL | Mark as:',
                  style: context.primaryTypography.paragraph.medium,
                ),
                20.boxHeight,
                ...Status.values.map(
                  (status) => GestureDetector(
                    onTap: () => changeStatus(status),
                    //do not remove: it allows tapping on the spacer
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Row(
                        children: [
                          SvgDecorator.square(
                            dimension: 20.l,
                            color: context.neutralColors.$800,
                            child: SvgPicture.asset(status.vectorAsset),
                          ),
                          8.boxWidth,
                          Text(
                            status.styledText,
                            style: context
                                .secondaryTypography.paragraph.medium.asRegular,
                          ),
                          const Spacer(),
                          SvgDecorator(
                            color: currentStatus == status
                                ? context.palette.secondary
                                : context.neutralColors.$200,
                            child: SvgPicture.asset(VectorAssets.pointer),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _PriorityLeveLModal extends StatefulWidget {
  final Priority initialPriority;
  final ValueChanged<Priority> onChanged;

  const _PriorityLeveLModal({
    Key? key,
    required this.initialPriority,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<_PriorityLeveLModal> createState() => _PriorityLeveLModalState();
}

class _PriorityLeveLModalState extends State<_PriorityLeveLModal> {
  late final ValueNotifier<Priority> priorityNotifier =
      ValueNotifier(widget.initialPriority);

  void changePriority(Priority priority) {
    if (priority == priorityNotifier.value) return;
    priorityNotifier.value = priority;
    widget.onChanged(priority);
  }

  @override
  Widget build(BuildContext context) {
    return ModalCard(
      gutterHeight: 44.02.h,
      child: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 16.h),
        child: ValueListenableBuilder<Priority>(
          valueListenable: priorityNotifier,
          builder: (_, currentStatus, __) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ASSIGN PRIORITY LEVEL',
                  style: context.primaryTypography.paragraph.medium,
                ),
                20.boxHeight,
                ...Priority.values.map(
                  (priority) => GestureDetector(
                    onTap: () => changePriority(priority),
                    //do not remove: it allows tapping on the spacer
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Row(
                        children: [
                          SvgDecorator.square(
                            dimension: 20.l,
                            child: SvgPicture.asset(priority.vectorAsset!),
                          ),
                          8.boxWidth,
                          Text(
                            priority.text!,
                            style: context
                                .secondaryTypography.paragraph.medium.asRegular,
                          ),
                          const Spacer(),
                          SvgDecorator(
                            color: currentStatus == priority
                                ? context.palette.secondary
                                : context.neutralColors.$200,
                            child: SvgPicture.asset(VectorAssets.pointer),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
