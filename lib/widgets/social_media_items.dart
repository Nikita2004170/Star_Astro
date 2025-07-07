import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
// import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common/utils/colors.dart';

class SocialMediaItems extends StatelessWidget {
  const SocialMediaItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0, top: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _iconView(Bootstrap.whatsapp, () async {}),
              const SizedBox(width: 18.0),
              _iconView(Bootstrap.instagram, () async {
                const url = 'https://www.instagram.com/starastro.ai/';
                await launch(url);
              }),
              const SizedBox(width: 18.0),
              _iconView(Bootstrap.twitter, () async {
                const url = 'https://x.com/StarAstroAI';
                await launch(url);
              }),
              const SizedBox(width: 18.0),
              _iconView(Bootstrap.linkedin, () async {
                const url = 'https://www.linkedin.com/company/starastro/';

                await launch(url);
              }),
            ],
          ),
          const SizedBox(height: 15.0),
          // Center(
          //   child: AppText(
          //     "${AppString.version} ${getIt.get<PackageInfo>().version}",
          //     fontSize: 14.0,
          //     fontFamily: sora,
          //     textColor: SDColors.whiteColor.withOpacity(0.5),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _iconView(IconData icon, GestureTapCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        color: SDColors.whiteColor,
        size: 24.0,
      ),
    );
  }
}
