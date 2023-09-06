import 'package:collection/collection.dart';
import 'package:html/parser.dart' as parser;

import '../../channels/channel_video.dart';
import '../../exceptions/exceptions.dart';
import '../../extensions/helpers_extension.dart';
import '../../retry.dart';
import '../../videos/videos.dart';
import '../models/initial_data.dart';
import '../models/youtube_page.dart';
import '../youtube_http_client.dart';

///
class ChannelUploadPage extends YoutubePage<_InitialData> {
  ///
  final String channelId;

  late final List<ChannelVideo> uploads = initialData.uploads;

  /// InitialData
  ChannelUploadPage.id(this.channelId, super.initialData)
      : super.fromInitialData();

  ///
  Future<ChannelUploadPage?> nextPage(YoutubeHttpClient httpClient) async {
    if (initialData.token.isEmpty) {
      return null;
    }

    final data = await httpClient.sendPost('browse', initialData.token);
    return ChannelUploadPage.id(channelId, _InitialData(data));
  }

  ///
  static Future<ChannelUploadPage> get(
    YoutubeHttpClient httpClient,
    String channelId,
    String sorting,
  ) {
    final url =
        'https://www.youtube.com/channel/$channelId/videos?view=0&sort=$sorting&flow=grid';
    return retry(httpClient, () async {
      final raw = await httpClient.getString(url);
      return ChannelUploadPage.parse(raw, channelId);
    });
  }

  ///
  ChannelUploadPage.parse(String raw, this.channelId)
      : super(parser.parse(raw), (root) => _InitialData(root));
}

class _InitialData extends InitialData {
  _InitialData(super.root);

  late final JsonMap? continuationContext = getContinuationContext();

  late final String token = continuationContext?.getT<String>('token') ??
      continuationContext?.getT<String>('continuation') ??
      '';

  late final List<ChannelVideo> uploads = _getUploads();

  List<ChannelVideo> _getUploads() {
    final content = getContentContext();
    if (content.isEmpty) {
      return const <ChannelVideo>[];
    }
    return content.map(_parseContent).whereNotNull().toList();
  }

  List<JsonMap> getContentContext() {
    List<JsonMap>? context;
    if (root.containsKey('contents')) {
      var render = root
          .get('contents')
          ?.get('twoColumnBrowseResultsRenderer')
          ?.getList('tabs')
          ?.map((e) => e['tabRenderer'])
          .cast<JsonMap>()
          .firstWhereOrNull((e) => e['selected'] as bool? ?? false)
          ?.get('content');

      if (render != null) {
        if (render.containsKey('sectionListRenderer')) {
          render = render
              .get('sectionListRenderer')
              ?.getList('contents')
              ?.firstOrNull
              ?.get('itemSectionRenderer')
              ?.getList('contents')
              ?.firstOrNull;

          if (render?.containsKey('gridRenderer') ?? false) {
            context =
                render?.get('gridRenderer')?.getList('items')?.cast<JsonMap>();
          } else if (render?.containsKey('messageRenderer') ?? false) {
            // Workaround for no-videos.
            context = const [];
          }
        } else if (render.containsKey('richGridRenderer')) {
          context =
              render.get('richGridRenderer')?.getList('contents') ?? const [];
        }
      }
    }
    if (context == null && root.containsKey('onResponseReceivedActions')) {
      context = root
          .getList('onResponseReceivedActions')
          ?.firstOrNull
          ?.get('appendContinuationItemsAction')
          ?.getList('continuationItems')
          ?.cast<JsonMap>();
    }
    if (context == null) {
      throw FatalFailureException('Failed to get initial data context.', 0);
    }
    return context;
  }

  JsonMap? getContinuationContext() {
    final continuationItemRenderer = getContentContext()
        .firstWhereOrNull((e) => e['continuationItemRenderer'] != null)
        ?.get('continuationItemRenderer');
    if (continuationItemRenderer != null) {
      final command = continuationItemRenderer
          .get('continuationEndpoint')
          ?.get('continuationCommand');
      if (command != null) {
        return command;
      }
    }
    if (root.containsKey('contents')) {
      return root
          .get('contents')
          ?.get('twoColumnBrowseResultsRenderer')
          ?.getList('tabs')
          ?.map((e) => e['tabRenderer'])
          .cast<JsonMap>()
          .firstWhereOrNull((e) => e['selected'] as bool? ?? false)
          ?.get('content')
          ?.get('sectionListRenderer')
          ?.getList('contents')
          ?.firstOrNull
          ?.get('itemSectionRenderer')
          ?.getList('contents')
          ?.firstOrNull
          ?.get('gridRenderer')
          ?.getList('items')
          ?.firstWhereOrNull((e) => e['continuationItemRenderer'] != null)
          ?.get('continuationItemRenderer')
          ?.get('continuationEndpoint')
          ?.get('continuationCommand');
    }
    if (root.containsKey('onResponseReceivedActions')) {
      return root
          .getList('onResponseReceivedActions')
          ?.firstOrNull
          ?.get('appendContinuationItemsAction')
          ?.getList('continuationItems')
          ?.firstWhereOrNull((e) => e['continuationItemRenderer'] != null)
          ?.get('continuationItemRenderer')
          ?.get('continuationEndpoint')
          ?.get('continuationCommand');
    }
    return null;
  }

  ChannelVideo? _parseContent(JsonMap? content) {
    if (content == null) {
      return null;
    }

    Map<String, dynamic>? video;
    if (content.containsKey('gridVideoRenderer')) {
      video = content.get('gridVideoRenderer');
    } else if (content.containsKey('richItemRenderer')) {
      video =
          content.get('richItemRenderer')?.get('content')?.get('videoRenderer');
    }

    if (video == null) {
      return null;
    }
    return ChannelVideo(
      VideoId(video.getT<String>('videoId')!),
      video.get('title')?.getT<String>('simpleText') ??
          video.get('title')?.getList('runs')?.map((e) => e['text']).join() ??
          '',
      video
              .getList('thumbnailOverlays')
              ?.firstOrNull
              ?.get('thumbnailOverlayTimeStatusRenderer')
              ?.get('text')
              ?.getT<String>('simpleText')
              ?.toDuration() ??
          Duration.zero,
      video.get('thumbnail')?.getList('thumbnails')?.last.getT<String>('url') ??
          '',
      video.get('publishedTimeText')?.getT<String>('simpleText') ?? '',
      video.get('viewCountText')?.getT<String>('simpleText').parseInt() ?? 0,
    );
  }
}

//
