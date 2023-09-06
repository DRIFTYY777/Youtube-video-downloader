import 'package:test/test.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

void main() {
  YoutubeExplode? yt;
  setUpAll(() {
    yt = YoutubeExplode();
  });

  tearDownAll(() {
    yt?.close();
  });

  test('Get metadata of a channel', () async {
    const channelUrl =
        'https://www.youtube.com/channel/UCEnBXANsKmyj2r9xVyKoDiQ';
    final channel = await yt!.channels.get(ChannelId(channelUrl));
    expect(channel.url, channelUrl);
    expect(channel.title, 'Oleksii Holub');
    expect(channel.logoUrl, isNotEmpty);
    expect(channel.logoUrl, isNot(equalsIgnoringWhitespace('')));
    expect(channel.subscribersCount, greaterThanOrEqualTo(190));
  });

  group('Get metadata of any channel', () {
    for (final val in {
      'UC46807r_RiRjH8IU-h_DrDQ',
      'UCJ6td3C9QlPO9O_J5dF4ZzA',
      'UCiGm_E4ZwYSHV3bcW1pnSeQ',
    }) {
      test('Channel - $val', () async {
        final channelId = ChannelId(val);
        final channel = await yt!.channels.get(channelId);
        expect(channel.id, channelId);
      });
    }
  });

  test('Get metadata of a channel by username', () async {
    final channel = await yt!.channels.getByUsername(Username('TheTyrrr'));
    expect(channel.id.value, 'UCEnBXANsKmyj2r9xVyKoDiQ');
  });

  test('Get metadata of a channel by handle', () async {
    final channel = await yt!.channels.getByHandle(ChannelHandle('@Hexer10'));
    expect(channel.id.value, 'UCqKbtOLx4NCBh5KKMSmbX0g');
  });

  test('Get metadata of a channel by a video', () async {
    final channel = await yt!.channels.getByVideo(VideoId('TW_yxPcodhk'));
    expect(channel.id.value, 'UCqKbtOLx4NCBh5KKMSmbX0g');
  });

  test('Get the videos of a youtube channel', () async {
    final videos = await yt!.channels
        .getUploads(
          ChannelId(
            'https://www.youtube.com/channel/UCqKbtOLx4NCBh5KKMSmbX0g',
          ),
        )
        .toList();
    expect(videos.length, greaterThanOrEqualTo(6));
  });

  group('Get the videos of any youtube channel', () {
    for (final val in {
      'UC46807r_RiRjH8IU-h_DrDQ',
      'UCJ6td3C9QlPO9O_J5dF4ZzA',
      'UCiGm_E4ZwYSHV3bcW1pnSeQ',
    }) {
      test('Channel - $val', () async {
        final videos = await yt!.channels.getUploads(ChannelId(val)).toList();
        expect(videos, isNotEmpty);
      });
    }
  });

  test('Get videos of a youtube channel from the uploads page', () async {
    final videos =
        await yt!.channels.getUploadsFromPage('UC46807r_RiRjH8IU-h_DrDQ');
    expect(videos, hasLength(30));
  });

  test('Get next page youtube channel uploads page', () async {
    final videos =
        await yt!.channels.getUploadsFromPage('UC46807r_RiRjH8IU-h_DrDQ');
    final nextPage = await videos.nextPage();
    expect(nextPage!.length, greaterThanOrEqualTo(20));
  });
}
