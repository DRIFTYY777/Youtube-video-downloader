import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http_parser/http_parser.dart';

import '../../reverse_engineering/models/fragment.dart';
import 'audio_stream_info.dart';
import 'bitrate.dart';
import 'filesize.dart';
import 'framerate.dart';
import 'stream_container.dart';
import 'stream_info.dart';
import 'video_quality.dart';
import 'video_resolution.dart';
import 'video_stream_info.dart';

part 'muxed_stream_info.g.dart';

/// YouTube media stream that contains both audio and video.
@JsonSerializable()
class MuxedStreamInfo with StreamInfo, AudioStreamInfo, VideoStreamInfo {
  @override
  final int tag;

  @override
  final Uri url;

  @override
  final StreamContainer container;

  @override
  final FileSize size;

  @override
  final Bitrate bitrate;

  @override
  final String audioCodec;

  @override
  final String videoCodec;

  /// Video quality label, as seen on YouTube.
  @Deprecated('Use qualityLabel')
  @override
  String get videoQualityLabel => qualityLabel;

  /// Video quality.
  @override
  final VideoQuality videoQuality;

  /// Video resolution.
  @override
  final VideoResolution videoResolution;

  /// Video framerate.
  @override
  final Framerate framerate;

  /// Muxed streams never have fragments.
  @override
  List<Fragment> get fragments => const [];

  /// Stream codec.
  @override
  @JsonKey(toJson: mediaTypeToJson, fromJson: mediaTypeFromJson)
  final MediaType codec;

  /// Stream codec.
  @override
  final String qualityLabel;

  /// Initializes an instance of [MuxedStreamInfo]
  MuxedStreamInfo(
    this.tag,
    this.url,
    this.container,
    this.size,
    this.bitrate,
    this.audioCodec,
    this.videoCodec,
    this.qualityLabel,
    this.videoQuality,
    this.videoResolution,
    this.framerate,
    this.codec,
  );

  @override
  String toString() =>
      'Muxed ($tag | ${videoResolution}p${framerate.framesPerSecond} | $container)';

  factory MuxedStreamInfo.fromJson(Map<String, dynamic> json) =>
      _$MuxedStreamInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MuxedStreamInfoToJson(this);
}
