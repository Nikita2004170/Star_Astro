import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../common/utils/colors.dart';
import '../../../../common/utils/styles.dart';
import '../../../../widgets/app_text.dart';
import '../../../models/const_settings.dart';

class UpiModeDialog extends StatelessWidget {
  const UpiModeDialog({
    super.key,
    required this.upiModes,
  });

  final List<ConstantSettings> upiModes;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.0,
      child: ListView.separated(
        itemCount: upiModes.length,
        clipBehavior: Clip.hardEdge,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final upiMode = upiModes[index];
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  context.pushNamed('routePaymentSuccess');
                },
                child: Image.asset(
                  upiMode.leadingImage ?? "",
                  height: 80.0,
                  width: 110.0,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              AppText(
                upiMode.title ?? "",
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                fontFamily: sora,
                textColor: SDColors.whiteColor,
              )
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 16.0,
          );
        },
      ),
    );
  }
}
