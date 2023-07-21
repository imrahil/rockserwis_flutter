// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'broadcast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Broadcast _$BroadcastFromJson(Map<String, dynamic> json) => Broadcast(
      broadcastId: json['broadcast_id'] as int,
      broadcastName: json['broadcast_name'] as String,
      hasPodcasts: json['has_podcasts'] as bool,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$BroadcastToJson(Broadcast instance) => <String, dynamic>{
      'broadcast_id': instance.broadcastId,
      'broadcast_name': instance.broadcastName,
      'image': instance.image,
      'has_podcasts': instance.hasPodcasts,
    };
