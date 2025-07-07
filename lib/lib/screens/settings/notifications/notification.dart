import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../common/utils/app_string.dart';
import '../../../../common/utils/colors.dart';
import '../../../../common/utils/common_widget.dart';
import '../../../../common/utils/styles.dart';
import '../../../../widgets/app_scaffold.dart';
import '../../../../widgets/app_text.dart';
import 'items/notification_item_view.dart';

@RoutePage()
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: SDColors.backgroundColor,
        title: AppText(
          AppString.notifications.toUpperCase(),
          textColor: SDColors.whiteColor.withOpacity(0.7),
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          fontFamily: sora,
          textAlign:
              TextAlign.center, // Ensure the text is centered within its space
        ),
        leading: IconButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: SDColors.whiteColor,
          ),
        ),
      ),
      body: _buildNotificationView(context),
    );
  }

  Widget _buildNotificationView(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8.0,
          ),
          Container(
            width: double.maxFinite,
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            decoration: const BoxDecoration(color: SDColors.settingsChart),
            child: AppText(
              AppString.recent.toUpperCase(),
              textColor: SDColors.whiteColor,
              fontSize: 16.0,
              fontFamily: sora,
              fontWeight: FontWeight.w600,
            ),
          ),
          divider(
            height: 0,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 100,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return const NotificationItemView();
              },
              separatorBuilder: (context, index) {
                return divider();
              },
            ),
          )
        ],
      ),
    );
  }
}
