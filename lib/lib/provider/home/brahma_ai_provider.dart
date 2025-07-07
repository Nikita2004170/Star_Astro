import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:one_context/one_context.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:star_astro/common/utils/colors.dart';
import 'package:star_astro/common/utils/context_utility.dart';
import 'package:star_astro/common/utils/string.dart';
import 'package:star_astro/di/di_services.dart';
import 'package:star_astro/lib/models/get_chat_model.dart';
import 'package:star_astro/lib/models/post_chat_model.dart';
import 'package:star_astro/lib/provider/home/chat_provider.dart';
import 'package:star_astro/lib/provider/home/chat_screen.dart';
import 'package:star_astro/lib/repository/chat_repository.dart';
import 'package:star_astro/lib/screens/settings/edit_profile/edit_profile.dart';
import 'package:star_astro/widgets/app_text.dart';
import '../../../common/utils/constanr_list.dart';
import '../../../common/utils/styles.dart';

class BrahmaAiProvider with ChangeNotifier {
  final brahmaAiQuestions = ConstantList.brahmaAiQuestion;
  final hanumanAiQuestions = ConstantList.matchmakingQuestions;
  final relationshipAiQuestions = ConstantList.relationshipAiQuestions;
  final numerologyAiQuestions = ConstantList.numerologyAiQuestions;
  final careerAiQuestions = ConstantList.careerAiQuestions;
  TextEditingController chatController = TextEditingController();
  final chatList = getChatList;
  bool isNewChat = true;
  final ScrollController scrollController = ScrollController();
  bool isTyping = false;
  String id = "";
  String typingResponse = '';
  String balance = "";
  bool canChat = true;
  List<ChatMessage> _chatList = [];
  bool _isLoading = false;

  List<ChatMessage> get chatLists => _chatList;
  bool get isLoading => _isLoading;

  void toggleChat(bool val) {
    canChat = val;
    notifyListeners();
  }

  void resetChat() {
    isNewChat = true;
    isTyping = false;
    id = "";
    chatList.clear();
    // notifyListeners();
  }

  chatStart() {
    isNewChat = false;
    notifyListeners();
  }

  updateBalance(String bal) {
    balance = bal;
    notifyListeners();
  }

  //Api Calling
  final ChatRepository _chatRepo = getIt.get<ChatRepository>();
  GetChatModel? chatResponse;

  String errorMessage = '';

  // Future<void> _callApi(
  //     String message, String aiType, dynamic partnerDetails) async {
  //   try {
  //     toggleChat(false);
  //     String endpoint = isNewChat || id == "" ? "new" : id;
  //     errorMessage = '';
  //     isTyping = true;
  //     chatStart();
  //     notifyListeners();

  //     // Build the payload
  //     PostChatModel model = PostChatModel(
  //       question: message,
  //       aiType: aiType,
  //       partnerDetails: aiType == "relationship" ? partnerDetails : null,
  //       // partnerDetails: partnerDetails,
  //     );

  //     final response = await _chatRepo.postChat(model, endpoint);
  //     notifyListeners();

  //     if (response.status == "fail") {
  //       ScaffoldMessenger.of(OneContext.instance.key.currentContext!)
  //           .showSnackBar(getSnackBar(
  //               response.data ?? StringResource.somethingWrong,
  //               isError: true));
  //     }

  //     if (response.status == "success") {
  //       id = response.data?.Id ?? '';
  //       updateBalance(response.data?.wallet?.balance.toString() ?? '0');
  //       int length = response.data?.chats?.length ?? 0;

  //       if (response.data?.chats?[length - 1].role == "assistant") {
  //         await _displayTypingEffect(
  //             response.data?.chats?[length - 1].text ?? 'Error');
  //       }

  //       isTyping = false;
  //       toggleChat(true);
  //       notifyListeners();
  //       _scrollToBottom();
  //     } else {
  //       chatList.add(ChatAiModel(
  //         id: chatList.length + 1,
  //         text: response.message ?? 'Error occurred during chat.',
  //         isSender: true,
  //         isError: true,
  //       ));
  //       isTyping = false;
  //       toggleChat(true);
  //       _scrollToBottom();
  //       notifyListeners();
  //     }
  //   } catch (e, stack) {
  //     print("❌ Exception in _callApi: $e");
  //     print("📌 Stack trace: $stack");

  //     isTyping = false;
  //     chatList.add(ChatAiModel(
  //       id: chatList.length + 1,
  //       text: "An error occurred while sending the message.",
  //       isSender: true,
  //       isError: true,
  //     ));
  //     toggleChat(true);
  //     _scrollToBottom();
  //     notifyListeners();
  //   }
  // }

  Future<void> _callApi(
      String message, String aiType, dynamic partnerDetails) async {
    try {
      toggleChat(false);
      String endpoint = isNewChat || id == "" ? "new" : id;
      errorMessage = '';
      isTyping = true;
      chatStart();
      notifyListeners();

      // Build the payload
      PostChatModel model = PostChatModel(
        question: message,
        aiType: aiType,
        partnerDetails: aiType == "relationship" ? partnerDetails : null,
      );

      final response = await _chatRepo.postChat(model, endpoint);

      if (response.status == "fail") {
        // Show SnackBar with response.message
        final context =
            OneContext.instance.key.currentContext ?? ContextUtility.context;
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message ?? StringResource.somethingWrong),
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.red,
              action:
                  response.message == 'Please complete your user profile first'
                      ? SnackBarAction(
                          label: 'Complete Profile',
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfileScreen(
                                          isFromLogin: true,
                                        )));
                          },
                        )
                      : null,
            ),
          );
        } else {
          log("Context unavailable, cannot show SnackBar");
        }
        isTyping = false;
        toggleChat(true);
        notifyListeners();
        _scrollToBottom();
        return; // Exit early to avoid further processing
      }

      if (response.status == "success") {
        id = response.data?.Id ?? '';
        updateBalance(response.data?.wallet?.balance.toString() ?? '0');
        int length = response.data?.chats?.length ?? 0;

        if (response.data?.chats != null &&
            length > 0 &&
            response.data!.chats![length - 1].role == "assistant") {
          await _displayTypingEffect(
              response.data!.chats![length - 1].text ?? 'Error');
        }

        isTyping = false;
        toggleChat(true);
        notifyListeners();
        _scrollToBottom();
      } else {
        chatList.add(ChatAiModel(
          id: chatList.length + 1,
          text: response.message ?? 'Error occurred during chat.',
          isSender: true,
          isError: true,
        ));
        isTyping = false;
        toggleChat(true);
        _scrollToBottom();
        notifyListeners();
      }
    } catch (e, stack) {
      log("❌ Exception in _callApi: $e");
      log("📌 Stack trace: $stack");

      isTyping = false;
      chatList.add(ChatAiModel(
        id: chatList.length + 1,
        text: "An error occurred while sending the message.",
        isSender: true,
        isError: true,
      ));
      toggleChat(true);
      _scrollToBottom();
      notifyListeners();

      // Show SnackBar for general errors
      final context =
          OneContext.instance.key.currentContext ?? ContextUtility.context;
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("An error occurred: $e"),
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        log("Context unavailable, cannot show SnackBar");
      }
    }
  }

  Future<void> _displayTypingEffect(String responseText) async {
    typingResponse = '';
    notifyListeners();

    for (int i = 0; i < responseText.length; i += 3) {
      typingResponse += responseText.substring(
          i, i + 3 > responseText.length ? responseText.length : i + 3);
      notifyListeners();
      _scrollToBottom();
      await Future.delayed(const Duration(milliseconds: 100));
    }

    chatList.add(ChatAiModel(
      id: chatList.length + 1,
      text: typingResponse,
      isSender: true,
    ));

    typingResponse = '';
    isTyping = false;
    notifyListeners();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<dynamic> fetchChatHistory(String chatId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString("access_token");

      if (accessToken == null) {
        debugPrint("Access token not found.");
        _isLoading = false;
        notifyListeners();
        return;
      }

      final response = await http.get(
        Uri.parse('https://api.test.starastrogpt.com/chat/$chatId'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      log('Response: ${response.body}');

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final chats = decoded['data']['chats'] as List<dynamic>;
        _chatList = chats
            .map((chat) => ChatMessage(
                  id: chat['_id'],
                  createdAt: chat['createdAt'],
                  updatedAt: chat['updatedAt'],
                  role: chat['role'],
                  text: chat['text'],
                ))
            .toList();
        // _isNewChat = _chatList.isEmpty; // Update isNewChat based on chatList
        print('Fetched chat list: $_chatList');
        notifyListeners(); // Notify UI to rebuild
      } else {
        debugPrint("Failed to fetch chats: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching chats: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> sendMessage(
      String message, String aiType, dynamic partnerDetails) async {
    if (message.isNotEmpty) {
      chatList.add(
        ChatAiModel(id: chatList.length + 1, text: message, isSender: false),
      );
      chatController.clear();
      notifyListeners();
      _scrollToBottom();

      log(message);
      log(aiType);

      await _callApi(message, aiType, partnerDetails);
    }
  }

  void historyBottomSheet(BuildContext ctx) {
    final chatProvider = Provider.of<ChatProvider>(ctx, listen: false);
    chatProvider.fetchChats();

    showModalBottomSheet(
        backgroundColor: SDColors.bottomSheetBack,
        context: ctx,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32.0)),
        ),
        builder: (ctx) {
          return Consumer<ChatProvider>(
            builder: (context, provider, _) {
              if (provider.isLoading) {
                return const Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              return SizedBox(
                // 👈 Bounded height!
                height:
                    MediaQuery.of(ctx).size.height * 0.8, // or any percentage
                child: Column(
                  children: [
                    // your header + divider...

                    Expanded(
                      child: provider.chatList.isEmpty
                          ? Center(
                              child: AppText(
                                "No chat history found",
                                textColor: SDColors.whiteColor.withOpacity(0.6),
                                fontFamily: karla,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                              ),
                            )
                          : ListView.separated(
                              itemCount: provider.chatList.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                final chat = provider.chatList[index];
                                return ListTile(
                                  title: AppText(
                                    chat.title,
                                    textColor: SDColors.whiteColor,
                                    fontFamily: karla,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.0,
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ChatScreen(
                                          chatId: chat.id,
                                          chatTitle: chat.title,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              separatorBuilder: (context, index) => Divider(
                                height: 20,
                                color: SDColors.whiteColor.withOpacity(0.1),
                              ),
                            ),
                    )

                    // footer...
                  ],
                ),
              );
            },
          );
        });
  }
}

List<ChatAiModel> get getChatList => [];

class ChatAiModel {
  final int id;
  final String? text;
  final bool? isSender;
  final bool? isError;

  const ChatAiModel({
    required this.id,
    this.text,
    this.isSender,
    this.isError = false,
  });
}
