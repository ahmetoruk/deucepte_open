// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Message _$$_MessageFromJson(Map<String, dynamic> json) => _$_Message(
      sender: json['sender'] as String,
      title: json['title'] as String,
      date: json['date'] as String,
      url: json['url'] as String,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$$_MessageToJson(_$_Message instance) =>
    <String, dynamic>{
      'sender': instance.sender,
      'title': instance.title,
      'date': instance.date,
      'url': instance.url,
      'content': instance.content,
    };
