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
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 18.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${collaborator.role} contact info',
            style: context.primaryTypography.paragraph.small.asMedium
                .withColor(context.palette.secondary),
          ),
          32.boxHeight,
          Text(
            collaborator.name,
            style: context.primaryTypography.title.small.asBold,
          ),
          24.boxHeight,
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: collaborator.contacts.length,
            separatorBuilder: (context, index) => 8.boxHeight,
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
