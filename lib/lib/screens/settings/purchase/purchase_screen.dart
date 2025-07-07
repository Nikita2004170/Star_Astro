import 'package:flutter/material.dart';
import '../../../../common/utils/app_string.dart';
import '../../../../common/utils/colors.dart';
import '../../../../common/utils/common_widget.dart';
import '../../../../common/utils/styles.dart';
import '../../../../widgets/app_scaffold.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/settings_app_bar.dart';
import 'items/invoice_item_view.dart';

// @RoutePage()
class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({super.key});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: _buildPurchaseView(context),
    );
  }

  Widget _buildPurchaseView(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsAppBar(
            title: AppString.purchases.toUpperCase(),
            leadingIcon: Icons.arrow_back_ios,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Container(
            width: double.maxFinite,
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            decoration: const BoxDecoration(color: SDColors.settingsChart),
            child: AppText(
              AppString.invoices.toUpperCase(),
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
                return InvoiceItemView(
                  index: index,
                );
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
