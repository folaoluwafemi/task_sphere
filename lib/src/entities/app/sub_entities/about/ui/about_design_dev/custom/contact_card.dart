part of '../about_design_dev_screen.dart';

class _ContactCard extends StatelessWidget {
  final ContactInfo collaborator;
  final int index;

  const _ContactCard({
    Key? key,
    required this.index,
    required this.collaborator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.bgColors.$50,
        borderRadius: Ui.circularBorder(7.l),
      ),
      padding: EdgeInsets.fromLTRB(18.w, 16.h, 18.w, 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${collaborator.role} contact info',
            style: context.primaryTypography.paragraph.small.asMedium
                .withColor(context.palette.secondary),
          ),
          24.boxHeight,
          Text(
            collaborator.name,
            style: context.primaryTypography.title.small.asBold,
          ),
          12.boxHeight,
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: collaborator.contacts.length,
            separatorBuilder: (context, index) => 4.boxHeight,
            itemBuilder: (context, index) => _ContactWidget(
              priority: index <= 2 ? Priority.values[2 - index] : Priority.low,
              contact: collaborator.contacts[index],
            ),
          ),
        ],
      ),
    );
  }
}
