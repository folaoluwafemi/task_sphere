part of '../about_design_dev_screen.dart';

class _AboutDesign$DevView extends StatelessWidget {
  const _AboutDesign$DevView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        SliverPinnedHeader(
          child: Container(
            color: context.palette.bgAccent,
            padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
            child: const _BackButton(),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            color: context.palette.bgAccent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                52.boxHeight,
                const _StackedText(),
                172.boxHeight,
              ],
            ),
          ),
        ),
        47.sliverBoxHeight,
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          sliver: SliverList.separated(
            itemCount: ContactContents.collaboratorContacts.length,
            separatorBuilder: (context, index) => 18.boxHeight,
            itemBuilder: (context, index) => _ContactCard(
              index: index,
              collaborator: ContactContents.collaboratorContacts[index],
            ),
          ),
        ),
        58.boxHeight,
        const SliverToBoxAdapter(
          child: _AboutTaskSphere(),
        )
      ],
    );
  }
}
