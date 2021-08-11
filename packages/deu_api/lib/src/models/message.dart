import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class Message with _$Message {
  factory Message(
      {required String sender,
      required String title,
      required String date,
      required String url,
      String? content}) = _Message;
  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  static final empty = Message(sender: '', title: '', date: '', url: '');
}
