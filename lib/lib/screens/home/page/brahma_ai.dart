// import 'package:auto_route/auto_route.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:star_astro/lib/models/partner_detail_model.dart';
import 'package:star_astro/widgets/app_scaffold.dart';
import 'package:star_astro/widgets/edit_text.dart';
// import '../../../../app_route.dart';
import '../../../../common/utils/app_string.dart';
import '../../../../common/utils/colors.dart';
import '../../../../common/utils/images.dart';
import '../../../../common/utils/styles.dart';
import '../../../../widgets/app_text.dart';
import '../../../provider/home/brahma_ai_provider.dart';
import 'package:star_astro/lib/screens/home/home_screen.dart' as home;

// @RoutePage()
class BrahmaAiScreen extends StatefulWidget {
  String? aiType;
  PartnerDetailsModel? partnerDetail;

  BrahmaAiScreen({super.key, this.aiType, this.partnerDetail});

  @override
  State<BrahmaAiScreen> createState() => _BrahmaAiScreenState();
}

class _BrahmaAiScreenState extends State<BrahmaAiScreen> {
  late BrahmaAiProvider _brahmaAiProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _brahmaAiProvider = Provider.of<BrahmaAiProvider>(context);
    // final globalProvider = Provider.of<GlobalProvider>(context);
    // _brahmaAiProvider.balance =
    //     globalProvider.userModel?.wallet?.balance.toString() ?? "0";
  }

  @override
  void dispose() {
    _brahmaAiProvider.resetChat();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.partnerDetail != null) {
      print(widget.partnerDetail!.dateOfBirth ?? 'No place of birth');
    } else {
      print('Partner details are null');
    }

    log("partner detaiklssssss is ::::::${widget.partnerDetail}");

    final brahmaAiProvider =
        Provider.of<BrahmaAiProvider>(context, listen: false);
    log("balance isssss:${brahmaAiProvider.balance.toString()}");
    return AppScaffold(
      body: (brahmaAiProvider.balance == "0")
          ? Center(
              child: Text(
                "Insufficient credits",
                style: TextStyle(color: Colors.white),
              ),
            )
          : _buildBrahmaAiView(context),
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
          widget.aiType == 'brahma'
              ? AppString.brahmaAi.toUpperCase()
              : widget.aiType == 'career'
                  ? AppString.careerAi.toUpperCase()
                  : widget.aiType == 'numerology'
                      ? AppString.numerologyAi.toUpperCase()
                      : widget.aiType == 'hanuman'
                          ? AppString.hanumanAi.toUpperCase()
                          : AppString.relationshipAi.toUpperCase(),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.push('/routeQuestionBundle');
                      },
                      child: Row(
                        children: [
                          Consumer<BrahmaAiProvider>(
                              builder: (context, provider, child) {
                            return AppText(
                              brahmaAiProvider.balance,
                              textColor: SDColors.whiteColor,
                              fontFamily: sora,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                            );
                          }),
                          const SizedBox(
                            width: 3.0,
                          ),
                          GestureDetector(
                            onTap: () => brahmaAiProvider.chatStart(),
                            child: Image.asset(
                              Images.flashIcon,
                              height: 30.0,
                              width: 30.0,
                              color: SDColors.whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        brahmaAiProvider.historyBottomSheet(context);
                      },
                      icon: const Icon(
                        size: 30,
                        Icons.history,
                        color: SDColors.whiteColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrahmaAiView(BuildContext context) {
    final brahmaAiProvider =
        Provider.of<BrahmaAiProvider>(context, listen: false);
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(color: SDColors.blackColor),

        // Positioned.fill(
        //   child:
        //   Image.asset(
        //     Images.bgImage,
        //     fit: BoxFit.cover,
        //   ),
        // ),
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                color: SDColors.dividerColor,
                height: 2.0,
                thickness: 1.0,
              ),

              /// By Default Chat Question
              /// Do Not Remove
              Consumer<BrahmaAiProvider>(
                builder: (context, provider, child) {
                  if (provider.isNewChat) {
                    return Expanded(
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
                            textColor: SDColors.unSelectedIcon.withOpacity(0.5),
                            fontSize: 16.0,
                            fontFamily: sora,
                            fontWeight: FontWeight.w400,
                          ),
                          AppText(
                            widget.aiType == 'brahma'
                                ? AppString.brahmaAi
                                : widget.aiType == 'hanuman'
                                    ? AppString.hanumanAi
                                    : widget.aiType == 'career'
                                        ? AppString.careerAi
                                        : widget.aiType == 'numerology'
                                            ? AppString.numerologyAi
                                            : AppString.relationshipAi,
                            textColor:
                                SDColors.settingsTextWhite.withOpacity(0.8),
                            fontSize: widget.aiType == 'numerology' ||
                                    widget.aiType == 'relationship'
                                ? 35.0
                                : 40.0,
                            fontFamily: sora,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    );
                  }

                  return Expanded(
                    child: ListView.separated(
                      controller: brahmaAiProvider.scrollController,
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 42.0),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        if (index == brahmaAiProvider.chatList.length) {
                          if (brahmaAiProvider.isTyping) {
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                margin: const EdgeInsets.only(right: 30.0),
                                decoration: BoxDecoration(
                                  color: SDColors.senderBack,
                                  borderRadius: BorderRadius.circular(12.0),
                                  border:
                                      Border.all(color: SDColors.dividerColor),
                                ),
                                child: AppText(
                                  brahmaAiProvider.typingResponse.isNotEmpty
                                      ? brahmaAiProvider.typingResponse
                                      : '${widget.aiType?[0].toUpperCase()}${widget.aiType?.substring(1)} AI is looking through your chart...',
                                  fontSize: 14.0,
                                  fontFamily: sora,
                                  fontWeight: FontWeight.w400,
                                  textColor: SDColors.settingsTextWhite,
                                ),
                              ),
                            );
                          }

                          if (brahmaAiProvider.errorMessage.isNotEmpty) {
                            return Container(
                              padding: const EdgeInsets.all(10.0),
                              margin: const EdgeInsets.only(right: 30.0),
                              decoration: BoxDecoration(
                                color: SDColors.senderBack,
                                borderRadius: BorderRadius.circular(12.0),
                                border:
                                    Border.all(color: SDColors.dividerColor),
                              ),
                              child: AppText(
                                brahmaAiProvider.errorMessage,
                                fontSize: 14.0,
                                fontFamily: sora,
                                fontWeight: FontWeight.w400,
                                textColor: SDColors.settingsTextWhite,
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        }

                        final chat = brahmaAiProvider.chatList[index];
                        if (chat.isSender ?? false) {
                          return Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10.0),
                                margin: const EdgeInsets.only(right: 30.0),
                                decoration: BoxDecoration(
                                  color: SDColors.senderBack,
                                  borderRadius: BorderRadius.circular(12.0),
                                  border:
                                      Border.all(color: SDColors.dividerColor),
                                ),
                                child: AppText(
                                  chat.text,
                                  fontSize: 14.0,
                                  fontFamily: sora,
                                  fontWeight: FontWeight.w400,
                                  textColor: SDColors.settingsTextWhite,
                                ),
                              ),
                              // TODO: Like and Dislike temporarily removed, to be added afterwards

                              // Padding(
                              //   padding:
                              //       const EdgeInsets.only(top: 5.0, left: 8.0),
                              //   child: Row(
                              //     children: [
                              //       Container(
                              //         decoration: const BoxDecoration(
                              //           shape: BoxShape.circle,
                              //           color: SDColors.senderBack,
                              //         ),
                              //         padding: const EdgeInsets.all(5.0),
                              //         child: Image.asset(
                              //           Images.like,
                              //           height: 16.0,
                              //           width: 16.0,
                              //         ),
                              //       ),
                              //       const SizedBox(
                              //         width: 8.0,
                              //       ),
                              //       Container(
                              //         decoration: const BoxDecoration(
                              //           shape: BoxShape.circle,
                              //           color: SDColors.senderBack,
                              //         ),
                              //         padding: const EdgeInsets.all(5.0),
                              //         child: Image.asset(
                              //           Images.disLike,
                              //           height: 15.0,
                              //           width: 15.0,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // )
                            ],
                          );
                        }
                        return Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            margin: const EdgeInsets.only(left: 30.0),
                            decoration: BoxDecoration(
                              color: SDColors.chatBack,
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(color: SDColors.dividerColor),
                            ),
                            child: Text(
                              chat.text ?? '',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: sora,
                                fontWeight: FontWeight.w400,
                                color: SDColors.settingsTextWhite,
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 16.0);
                      },
                      itemCount: brahmaAiProvider.chatList.length + 1,
                    ),
                  );
                },
              ),

              const SizedBox(
                height: 15.0,
              ),
              SizedBox(
                height: 40.0,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),

                  itemBuilder: (context, index) {
                    // Select the correct question list based on aiType
                    final aiType = widget.aiType ?? '';
                    final questions = aiType == 'hanuman'
                        ? brahmaAiProvider.hanumanAiQuestions
                        : aiType == 'career'
                            ? brahmaAiProvider.careerAiQuestions
                            : aiType == 'relationship'
                                ? brahmaAiProvider.relationshipAiQuestions
                                : brahmaAiProvider
                                    .brahmaAiQuestions; // default to brahma

                    final question = questions[index];

                    return GestureDetector(
                      onTap: () async {
                        print('Send tapped');
                        print('canChat: ${brahmaAiProvider.canChat}');
                        print(
                            'message: ${brahmaAiProvider.chatController.text}');
                        brahmaAiProvider.chatController.text =
                            question.title ?? '';

                        if (brahmaAiProvider.canChat) {
                          String apiAiType = widget.aiType == 'hanuman'
                              ? 'brahma'
                              : widget.aiType ?? '';

                          await brahmaAiProvider.sendMessage(
                            brahmaAiProvider.chatController.text,
                            apiAiType,
                            widget.partnerDetail,
                          );
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          color: SDColors.sendChatBack,
                          border: Border.all(color: SDColors.dividerColor),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: AppText(
                          question.title ?? "",
                          textColor: SDColors.settingsTextWhite,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: sora,
                        ),
                      ),
                    );
                  },

                  // Same conditional list used here for count
                  itemCount: () {
                    final aiType = widget.aiType ?? '';
                    if (aiType == 'hanuman') {
                      return brahmaAiProvider.hanumanAiQuestions.length;
                    }
                    if (aiType == 'career') {
                      return brahmaAiProvider.careerAiQuestions.length;
                    }
                    if (aiType == 'relationship') {
                      return brahmaAiProvider.relationshipAiQuestions.length;
                    }
                    return brahmaAiProvider.brahmaAiQuestions.length;
                  }(),

                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(width: 8.0),
                ),
              ),

              const SizedBox(
                height: 8.0,
              ),
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
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: brahmaAiProvider.chatController,
                        hintText: "Chat with ${widget.aiType} AI",
                        hintColor: SDColors.referCopy,
                        fontSize: 17.0,
                        onTapOutside: (event) {},
                        fontWeight: FontWeight.w400,
                        textColor: SDColors.whiteColor,
                        fillColor: SDColors.sendChatBack,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        print('Send tapped');
                        print('canChat: ${brahmaAiProvider.canChat}');
                        print(
                            'message: ${brahmaAiProvider.chatController.text}');

                        if (brahmaAiProvider.canChat) {
                          String apiAiType = widget.aiType == 'hanuman'
                              ? 'brahma'
                              : widget.aiType ?? '';

                          print(apiAiType);
                          print(brahmaAiProvider.chatController.text);
                          print(apiAiType);
                          print(widget.partnerDetail.runtimeType);
                          print(widget.partnerDetail);
                          await brahmaAiProvider.sendMessage(
                              brahmaAiProvider.chatController.text,
                              apiAiType,
                              widget.partnerDetail);
                        }
                      },
                      child: Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Container(
                            height: 42,
                            width: 42,
                            decoration: BoxDecoration(
                                gradient: const RadialGradient(colors: [
                                  SDColors.purpule,
                                  Color(0xff341E5F)
                                ]),
                                borderRadius: BorderRadius.circular(12)),
                            child: const Icon(
                              Icons.arrow_upward_sharp,
                              color: SDColors.whiteColor,
                              size: 24,
                            ),
                          )
                          // Image.asset(
                          //   Images.send,
                          //   height: 32.0,
                          //   width: 32.0,
                          // ),
                          ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
