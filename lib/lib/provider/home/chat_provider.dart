import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChatProvider extends ChangeNotifier {
  List<ChatModel> _chatList = [];
  bool _isLoading = false;

  List<ChatModel> get chatList => _chatList;
  bool get isLoading => _isLoading;

  Future<void> fetchChats() async {
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
        Uri.parse('https://api.test.starastrogpt.com/chat'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      log('Response: ${response.body}');

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final List data = decoded['data'];
        _chatList = data.map((e) => ChatModel.fromJson(e)).toList();
      } else {
        debugPrint("Failed to fetch chats: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching chats: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchChatHistory(String chatId) async {
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
        final List data = decoded['data']['chats'];
        log(data.toString());
        _chatList = data.map((e) => ChatModel.fromJson(e)).toList();
      } else {
        debugPrint("Failed to fetch chats: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching chats: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}

class ChatModel {
  final String id;
  final String title;
  final DateTime createdAt;

  ChatModel({
    required this.id,
    required this.title,
    required this.createdAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['_id'],
      title: json['title'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class ChatMessage {
  final String id;
  final String role;
  final String text;
  final String createdAt;
  final String updatedAt;

  ChatMessage({
    required this.id,
    required this.role,
    required this.text,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['_id']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      text: json['text']?.toString() ?? '',
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'role': role,
      'text': text,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class ChatHistory {
  final String id;
  final String user;
  final String title;
  final List<ChatMessage> chats;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  ChatHistory({
    required this.id,
    required this.user,
    required this.title,
    required this.chats,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory ChatHistory.fromJson(Map<String, dynamic> json) {
    var chatsJson = json['chats'] as List<dynamic>? ?? [];
    List<ChatMessage> chatsList = chatsJson
        .whereType<Map<String, dynamic>>()
        .map((chat) => ChatMessage.fromJson(chat))
        .toList();

    return ChatHistory(
      id: json['_id']?.toString() ?? '',
      user: json['user']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      chats: chatsList,
      createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? '') ??
          DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt']?.toString() ?? '') ??
          DateTime.now(),
      version: (json['__v'] is int)
          ? json['__v']
          : int.tryParse(json['__v']?.toString() ?? '0') ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user,
      'title': title,
      'chats': chats.map((chat) => chat.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }
}

class ChatResponse {
  final String status;
  final String message;
  final ChatHistory data;

  ChatResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(
      status: json['status']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      data: ChatHistory.fromJson(
          json['data'] is Map<String, dynamic> ? json['data'] : {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
    };
  }
}
