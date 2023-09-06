// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, require_trailing_commas

part of 'video_only_stream_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoOnlyStreamInfo _$VideoOnlyStreamInfoFromJson(Map<String, dynamic> json) =>
    VideoOnlyStreamInfo(
      json['tag'] as int,
      Uri.parse(json['url'] as String),
      StreamContainer.fromJson(json['container'] as Map<String, dynamic>),
      FileSize.fromJson(json['size'] as Map<String, dynamic>),
      Bitrate.fromJson(json['bitrate'] as Map<String, dynamic>),
      json['videoCodec'] as String,
      json['qualityLabel'] as String,
      $enumDecode(_$VideoQualityEnumMap, json['videoQuality']),
      VideoResolution.fromJson(json['videoResolution'] as Map<String, dynamic>),
      Framerate.fromJson(json['framerate'] as Map<String, dynamic>),
      (json['fragments'] as List<dynamic>)
          .map((e) => Fragment.fromJson(e as Map<String, dynamic>))
          .toList(),
      mediaTypeFromJson(json['codec'] as String),
    );

Map<String, dynamic> _$VideoOnlyStreamInfoToJson(
        VideoOnlyStreamInfo instance) =>
    <String, dynamic>{
      'tag': instance.tag,
      'url': instance.url.toString(),
      'container': instance.container,
      'size': instance.size,
      'bitrate': instance.bitrate,
      'videoCodec': instance.videoCodec,
      'qualityLabel': instance.qualityLabel,
      'videoQuality': _$VideoQualityEnumMap[instance.videoQuality]!,
      'videoResolution': instance.videoResolution,
      'framerate': instance.framerate,
      'fragments': instance.fragments,
      'codec': mediaTypeToJson(instance.codec),
    };

const _$VideoQualityEnumMap = {
  VideoQuality.unknown: 'unknown',
  VideoQuality.low144: 'low144',
  VideoQuality.low240: 'low240',
  VideoQuality.medium360: 'medium360',
  VideoQuality.medium480: 'medium480',
  VideoQuality.high720: 'high720',
  VideoQuality.high1080: 'high1080',
  VideoQuality.high1440: 'high1440',
  VideoQuality.high2160: 'high2160',
  VideoQuality.high2880: 'high2880',
  VideoQuality.high3072: 'high3072',
  VideoQuality.high4320: 'high4320',
};
