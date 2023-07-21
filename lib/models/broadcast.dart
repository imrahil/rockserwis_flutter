import 'package:json_annotation/json_annotation.dart';

part 'broadcast.g.dart';

@JsonSerializable()
class Broadcast {
    @JsonKey(name: 'broadcast_id')
    final int broadcastId;

    @JsonKey(name: 'broadcast_name')
    final String broadcastName;

    final String? image;

    @JsonKey(name: 'has_podcasts')
    final bool hasPodcasts;

    Broadcast({required this.broadcastId, required this.broadcastName, required this.hasPodcasts, required this.image});

    factory Broadcast.fromJson(Map<String, dynamic> json) => _$BroadcastFromJson(json);

    Map<String, dynamic> toJson() => _$BroadcastToJson(this);
}