part of '../task_screen.dart';

typedef _DescriptorRecord = (Status status, Priority priority);

class _DescriptorPickerDialog extends StatefulWidget {
  final ValueChanged<_DescriptorRecord> onChanged;
  final _DescriptorRecord initialValue;

  const _DescriptorPickerDialog({
    Key? key,
    required this.onChanged,
    required this.initialValue,
  }) : super(key: key);

  @override
  State<_DescriptorPickerDialog> createState() =>
      _DescriptorPickerDialogState();
}

class _DescriptorPickerDialogState extends State<_DescriptorPickerDialog> {
  late Status currentStatus = widget.initialValue.$1;
  late Priority currentPriority = widget.initialValue.$2;

  void changeStatus(Status status) {
    currentStatus = status;
    onChanged();
  }

  void changePriority(Priority priority) {
    currentPriority = priority;
    onChanged();
  }

  void onChanged() {
    widget.onChanged((currentStatus, currentPriority));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _CompletionLevelModal(
            initialStatus: widget.initialValue.$1,
            onChanged: changeStatus,
          ),
          16.boxHeight,
          _PriorityLeveLModal(
            initialPriority: widget.initialValue.$2,
            onChanged: changePriority,
          ),
          32.boxHeight,
          LargeButton(
            onPressed: () => Navigator.of(context).pop(),
            color: context.neutralColors.$700,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 13.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgDecorator.square(
                    dimension: 20.l,
                    color: context.bgColors.$50,
                    child: SvgPicture.asset(VectorAssets.closeX),
                  ),
                  8.boxWidth,
                  Text(
                    'Close',
                    style: context.buttonTextStyle.withColor(
                      context.bgColors.$50,
                    ),
                  ),
                ],
              ),
            ),
          ),
          18.boxHeight,
        ],
      ),
    );
  }
}
