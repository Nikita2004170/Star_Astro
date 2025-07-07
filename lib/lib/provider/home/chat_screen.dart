import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:star_astro/lib/provider/home/brahma_ai_provider.dart';
import 'package:star_astro/lib/screens/home/home_screen.dart' as home;
import 'package:star_astro/widgets/app_scaffold.dart';
import 'package:star_astro/common/utils/app_string.dart';
import 'package:star_astro/common/utils/colors.dart';
import 'package:star_astro/common/utils/images.dart';
import 'package:star_astro/common/utils/styles.dart';
import 'package:star_astro/widgets/app_text.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String chatTitle;

  const ChatScreen({super.key, required this.chatId, required this.chatTitle});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late BrahmaAiProvider _brahmaAiProvider;

  @override
  void initState() {
    super.initState();
    _brahmaAiProvider = Provider.of<BrahmaAiProvider>(context, listen: false);
    _brahmaAiProvider.fetchChatHistory(widget.chatId).then((_) {
      print('Chat list length: ${_brahmaAiProvider.chatLists.length}');
    });
    fetchChatHistory();
  }

  fetchChatHistory() async {
    await _brahmaAiProvider.fetchChatHistory(widget.chatId);
  }

  @override
  void dispose() {
    _brahmaAiProvider.resetChat();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brahmaAiProvider =
        Provider.of<BrahmaAiProvider>(context, listen: false);
    log("balannce is ::${brahmaAiProvider.balance} ");
    return WillPopScope(
      onWillPop: () async {
        context.go('/home_screen');
        return false;
      },
      child: AppScaffold(
        body: (brahmaAiProvider.balance == "0")
            ? Center(
                child: Text("Insufficient credits"),
              )
            : _buildChatView(context),
        appBar: AppBar(
          backgroundColor: SDColors.blackColor,
          leadingWidth: 35.0,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const home.HomeScreen()),
                );
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: SDColors.whiteColor,
              ),
            ),
          ),
          title: AppText(
            'History',
            textColor: SDColors.whiteColor.withOpacity(0.7),
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            fontFamily: sora,
            textAlign: TextAlign.center,
          ),
          actions: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Consumer<BrahmaAiProvider>(
                builder: (context, provider, child) {
                  return AppText(
                    provider.balance,
                    textColor: SDColors.whiteColor,
                    fontFamily: sora,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatView(BuildContext context) {
    return Consumer<BrahmaAiProvider>(
      builder: (context, provider, child) {
        return (provider.balance.toString() == "0")
            ? Center(
                child: Text(
                  "There is not sufficient credits",
                  style: TextStyle(color: SDColors.whiteColor),
                ),
              )
            : Stack(
                fit: StackFit.expand,
                children: [
                  Container(color: SDColors.blackColor),
                  SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.balance,
                          style: TextStyle(color: SDColors.appRed),
                        ),
                        const Divider(
                          color: SDColors.dividerColor,
                          height: 2.0,
                          thickness: 1.0,
                        ),
                        if (provider.isNewChat && provider.chatLists.isEmpty)
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Image.asset(
                                    Images.appLogo,
                                    width: 99.0,
                                    height: 104.0,
                                  ),
                                ),
                                AppText(
                                  AppString.startFirstChat,
                                  textColor:
                                      SDColors.unSelectedIcon.withOpacity(0.5),
                                  fontSize: 16.0,
                                  fontFamily: sora,
                                  fontWeight: FontWeight.w400,
                                ),
                                // Text(
                                //   provider.balance,
                                //   style: TextStyle(color: SDColors.appRed),
                                // ),
                              ],
                            ),
                          )
                        else
                          Expanded(
                            child: ListView.separated(
                              controller: provider.scrollController,
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 42.0),
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                if (index == provider.chatLists.length) {
                                  if (provider.isTyping) {
                                    return Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        padding: const EdgeInsets.all(10.0),
                                        margin:
                                            const EdgeInsets.only(right: 30.0),
                                        decoration: BoxDecoration(
                                          color: SDColors.senderBack,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          border: Border.all(
                                              color: SDColors.dividerColor),
                                        ),
                                        child: AppText(
                                          provider.typingResponse.isNotEmpty
                                              ? provider.typingResponse
                                              : 'AI is looking through your chart...',
                                          fontSize: 14.0,
                                          fontFamily: sora,
                                          fontWeight: FontWeight.w400,
                                          textColor: SDColors.settingsTextWhite,
                                        ),
                                      ),
                                    );
                                  }
                                  if (provider.errorMessage.isNotEmpty) {
                                    return Container(
                                      padding: const EdgeInsets.all(10.0),
                                      margin:
                                          const EdgeInsets.only(right: 30.0),
                                      decoration: BoxDecoration(
                                        color: SDColors.senderBack,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        border: Border.all(
                                            color: SDColors.dividerColor),
                                      ),
                                      child: AppText(
                                        provider.errorMessage,
                                        fontSize: 14.0,
                                        fontFamily: sora,
                                        fontWeight: FontWeight.w400,
                                        textColor: SDColors.settingsTextWhite,
                                      ),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                }

                                final chat = provider.chatLists[index];
                                final isSender = chat.role == 'assistant';
                                return Align(
                                  alignment: isSender
                                      ? Alignment.centerLeft
                                      : Alignment.centerRight,
                                  child: Container(
                                    padding: const EdgeInsets.all(10.0),
                                    margin: isSender
                                        ? const EdgeInsets.only(right: 30.0)
                                        : const EdgeInsets.only(left: 30.0),
                                    decoration: BoxDecoration(
                                      color: isSender
                                          ? SDColors.senderBack
                                          : SDColors.chatBack,
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(
                                          color: SDColors.dividerColor),
                                    ),
                                    child: AppText(
                                      chat.text,
                                      fontSize: 14.0,
                                      fontFamily: sora,
                                      fontWeight: FontWeight.w400,
                                      textColor: SDColors.settingsTextWhite,
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 16.0);
                              },
                              itemCount: provider.chatLists.length + 1,
                            ),
                          ),
                        const SizedBox(height: 8.0),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 16.0, right: 16.0, bottom: 32.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: SDColors.sendChatBack,
                            border: Border.all(color: SDColors.dividerColor),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
      },
    );
  }
}
