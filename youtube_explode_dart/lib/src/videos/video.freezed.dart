// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Video {
  /// Video ID.
  VideoId get id => throw _privateConstructorUsedError;

  /// Video title.
  String get title => throw _privateConstructorUsedError;

  /// Video author.
  String get author => throw _privateConstructorUsedError;

  /// Video author Id.
  ChannelId get channelId => throw _privateConstructorUsedError;

  /// Video upload date.
  /// Note: For search queries it is calculated with:
  ///   DateTime.now() - how much time is was published.
  DateTime? get uploadDate => throw _privateConstructorUsedError;
  String? get uploadDateRaw => throw _privateConstructorUsedError;

  /// Video publish date.
  DateTime? get publishDate => throw _privateConstructorUsedError;

  /// Video description.
  String get description => throw _privateConstructorUsedError;

  /// Duration of the video.
  Duration? get duration => throw _privateConstructorUsedError;

  /// Available thumbnails for this video.
  ThumbnailSet get thumbnails => throw _privateConstructorUsedError;

  /// Search keywords used for this video.
  UnmodifiableListView<String> get keywords =>
      throw _privateConstructorUsedError;

  /// Engagement statistics for this video.
  Engagement get engagement => throw _privateConstructorUsedError;

  /// Returns true if this is a live stream.
//ignore: avoid_positional_boolean_parameters
  bool get isLive => throw _privateConstructorUsedError;

  /// Used internally.
  /// Shouldn't be used in the code.
  @internal
  WatchPage? get watchPage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VideoCopyWith<Video> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoCopyWith<$Res> {
  factory $VideoCopyWith(Video value, $Res Function(Video) then) =
      _$VideoCopyWithImpl<$Res, Video>;
  @useResult
  $Res call(
      {VideoId id,
      String title,
      String author,
      ChannelId channelId,
      DateTime? uploadDate,
      String? uploadDateRaw,
      DateTime? publishDate,
      String description,
      Duration? duration,
      ThumbnailSet thumbnails,
      UnmodifiableListView<String> keywords,
      Engagement engagement,
      bool isLive,
      @internal WatchPage? watchPage});

  $VideoIdCopyWith<$Res> get id;
  $ChannelIdCopyWith<$Res> get channelId;
  $ThumbnailSetCopyWith<$Res> get thumbnails;
  $EngagementCopyWith<$Res> get engagement;
}

/// @nodoc
class _$VideoCopyWithImpl<$Res, $Val extends Video>
    implements $VideoCopyWith<$Res> {
  _$VideoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? author = null,
    Object? channelId = null,
    Object? uploadDate = freezed,
    Object? uploadDateRaw = freezed,
    Object? publishDate = freezed,
    Object? description = null,
    Object? duration = freezed,
    Object? thumbnails = null,
    Object? keywords = null,
    Object? engagement = null,
    Object? isLive = null,
    Object? watchPage = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as VideoId,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      channelId: null == channelId
          ? _value.channelId
          : channelId // ignore: cast_nullable_to_non_nullable
              as ChannelId,
      uploadDate: freezed == uploadDate
          ? _value.uploadDate
          : uploadDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      uploadDateRaw: freezed == uploadDateRaw
          ? _value.uploadDateRaw
          : uploadDateRaw // ignore: cast_nullable_to_non_nullable
              as String?,
      publishDate: freezed == publishDate
          ? _value.publishDate
          : publishDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      thumbnails: null == thumbnails
          ? _value.thumbnails
          : thumbnails // ignore: cast_nullable_to_non_nullable
              as ThumbnailSet,
      keywords: null == keywords
          ? _value.keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as UnmodifiableListView<String>,
      engagement: null == engagement
          ? _value.engagement
          : engagement // ignore: cast_nullable_to_non_nullable
              as Engagement,
      isLive: null == isLive
          ? _value.isLive
          : isLive // ignore: cast_nullable_to_non_nullable
              as bool,
      watchPage: freezed == watchPage
          ? _value.watchPage
          : watchPage // ignore: cast_nullable_to_non_nullable
              as WatchPage?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $VideoIdCopyWith<$Res> get id {
    return $VideoIdCopyWith<$Res>(_value.id, (value) {
      return _then(_value.copyWith(id: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ChannelIdCopyWith<$Res> get channelId {
    return $ChannelIdCopyWith<$Res>(_value.channelId, (value) {
      return _then(_value.copyWith(channelId: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ThumbnailSetCopyWith<$Res> get thumbnails {
    return $ThumbnailSetCopyWith<$Res>(_value.thumbnails, (value) {
      return _then(_value.copyWith(thumbnails: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $EngagementCopyWith<$Res> get engagement {
    return $EngagementCopyWith<$Res>(_value.engagement, (value) {
      return _then(_value.copyWith(engagement: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_VideoCopyWith<$Res> implements $VideoCopyWith<$Res> {
  factory _$$_VideoCopyWith(_$_Video value, $Res Function(_$_Video) then) =
      __$$_VideoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {VideoId id,
      String title,
      String author,
      ChannelId channelId,
      DateTime? uploadDate,
      String? uploadDateRaw,
      DateTime? publishDate,
      String description,
      Duration? duration,
      ThumbnailSet thumbnails,
      UnmodifiableListView<String> keywords,
      Engagement engagement,
      bool isLive,
      @internal WatchPage? watchPage});

  @override
  $VideoIdCopyWith<$Res> get id;
  @override
  $ChannelIdCopyWith<$Res> get channelId;
  @override
  $ThumbnailSetCopyWith<$Res> get thumbnails;
  @override
  $EngagementCopyWith<$Res> get engagement;
}

/// @nodoc
class __$$_VideoCopyWithImpl<$Res> extends _$VideoCopyWithImpl<$Res, _$_Video>
    implements _$$_VideoCopyWith<$Res> {
  __$$_VideoCopyWithImpl(_$_Video _value, $Res Function(_$_Video) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? author = null,
    Object? channelId = null,
    Object? uploadDate = freezed,
    Object? uploadDateRaw = freezed,
    Object? publishDate = freezed,
    Object? description = null,
    Object? duration = freezed,
    Object? thumbnails = null,
    Object? keywords = null,
    Object? engagement = null,
    Object? isLive = null,
    Object? watchPage = freezed,
  }) {
    return _then(_$_Video(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as VideoId,
      null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      null == channelId
          ? _value.channelId
          : channelId // ignore: cast_nullable_to_non_nullable
              as ChannelId,
      freezed == uploadDate
          ? _value.uploadDate
          : uploadDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      freezed == uploadDateRaw
          ? _value.uploadDateRaw
          : uploadDateRaw // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == publishDate
          ? _value.publishDate
          : publishDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      null == thumbnails
          ? _value.thumbnails
          : thumbnails // ignore: cast_nullable_to_non_nullable
              as ThumbnailSet,
      null == keywords
          ? _value.keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as UnmodifiableListView<String>,
      null == engagement
          ? _value.engagement
          : engagement // ignore: cast_nullable_to_non_nullable
              as Engagement,
      null == isLive
          ? _value.isLive
          : isLive // ignore: cast_nullable_to_non_nullable
              as bool,
      freezed == watchPage
          ? _value.watchPage
          : watchPage // ignore: cast_nullable_to_non_nullable
              as WatchPage?,
    ));
  }
}

/// @nodoc

class _$_Video extends _Video {
  const _$_Video(
      this.id,
      this.title,
      this.author,
      this.channelId,
      this.uploadDate,
      this.uploadDateRaw,
      this.publishDate,
      this.description,
      this.duration,
      this.thumbnails,
      this.keywords,
      this.engagement,
      this.isLive,
      [@internal this.watchPage])
      : super._();

  /// Video ID.
  @override
  final VideoId id;

  /// Video title.
  @override
  final String title;

  /// Video author.
  @override
  final String author;

  /// Video author Id.
  @override
  final ChannelId channelId;

  /// Video upload date.
  /// Note: For search queries it is calculated with:
  ///   DateTime.now() - how much time is was published.
  @override
  final DateTime? uploadDate;
  @override
  final String? uploadDateRaw;

  /// Video publish date.
  @override
  final DateTime? publishDate;

  /// Video description.
  @override
  final String description;

  /// Duration of the video.
  @override
  final Duration? duration;

  /// Available thumbnails for this video.
  @override
  final ThumbnailSet thumbnails;

  /// Search keywords used for this video.
  @override
  final UnmodifiableListView<String> keywords;

  /// Engagement statistics for this video.
  @override
  final Engagement engagement;

  /// Returns true if this is a live stream.
//ignore: avoid_positional_boolean_parameters
  @override
  final bool isLive;

  /// Used internally.
  /// Shouldn't be used in the code.
  @override
  @internal
  final WatchPage? watchPage;

  @override
  String toString() {
    return 'Video._internal(id: $id, title: $title, author: $author, channelId: $channelId, uploadDate: $uploadDate, uploadDateRaw: $uploadDateRaw, publishDate: $publishDate, description: $description, duration: $duration, thumbnails: $thumbnails, keywords: $keywords, engagement: $engagement, isLive: $isLive, watchPage: $watchPage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Video &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.channelId, channelId) ||
                other.channelId == channelId) &&
            (identical(other.uploadDate, uploadDate) ||
                other.uploadDate == uploadDate) &&
            (identical(other.uploadDateRaw, uploadDateRaw) ||
                other.uploadDateRaw == uploadDateRaw) &&
            (identical(other.publishDate, publishDate) ||
                other.publishDate == publishDate) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.thumbnails, thumbnails) ||
                other.thumbnails == thumbnails) &&
            const DeepCollectionEquality().equals(other.keywords, keywords) &&
            (identical(other.engagement, engagement) ||
                other.engagement == engagement) &&
            (identical(other.isLive, isLive) || other.isLive == isLive) &&
            (identical(other.watchPage, watchPage) ||
                other.watchPage == watchPage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      author,
      channelId,
      uploadDate,
      uploadDateRaw,
      publishDate,
      description,
      duration,
      thumbnails,
      const DeepCollectionEquality().hash(keywords),
      engagement,
      isLive,
      watchPage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_VideoCopyWith<_$_Video> get copyWith =>
      __$$_VideoCopyWithImpl<_$_Video>(this, _$identity);
}

abstract class _Video extends Video {
  const factory _Video(
      final VideoId id,
      final String title,
      final String author,
      final ChannelId channelId,
      final DateTime? uploadDate,
      final String? uploadDateRaw,
      final DateTime? publishDate,
      final String description,
      final Duration? duration,
      final ThumbnailSet thumbnails,
      final UnmodifiableListView<String> keywords,
      final Engagement engagement,
      final bool isLive,
      [@internal final WatchPage? watchPage]) = _$_Video;
  const _Video._() : super._();

  @override

  /// Video ID.
  VideoId get id;
  @override

  /// Video title.
  String get title;
  @override

  /// Video author.
  String get author;
  @override

  /// Video author Id.
  ChannelId get channelId;
  @override

  /// Video upload date.
  /// Note: For search queries it is calculated with:
  ///   DateTime.now() - how much time is was published.
  DateTime? get uploadDate;
  @override
  String? get uploadDateRaw;
  @override

  /// Video publish date.
  DateTime? get publishDate;
  @override

  /// Video description.
  String get description;
  @override

  /// Duration of the video.
  Duration? get duration;
  @override

  /// Available thumbnails for this video.
  ThumbnailSet get thumbnails;
  @override

  /// Search keywords used for this video.
  UnmodifiableListView<String> get keywords;
  @override

  /// Engagement statistics for this video.
  Engagement get engagement;
  @override

  /// Returns true if this is a live stream.
//ignore: avoid_positional_boolean_parameters
  bool get isLive;
  @override

  /// Used internally.
  /// Shouldn't be used in the code.
  @internal
  WatchPage? get watchPage;
  @override
  @JsonKey(ignore: true)
  _$$_VideoCopyWith<_$_Video> get copyWith =>
      throw _privateConstructorUsedError;
}
