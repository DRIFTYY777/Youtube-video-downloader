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

  test('Get comments of a video', () async {
    const videoUrl = 'https://www.youtube.com/watch?v=TW_yxPcodhk';
    final video = await yt!.videos.get(VideoId(videoUrl));
    final comments = (await yt!.videos.commentsClient.getComments(video))!;
    expect(comments.length, greaterThanOrEqualTo(1));
    expect(comments.totalLength, greaterThanOrEqualTo(1));
    expect(comments.first.isHearted, false);
  });

  test('Comments of video with no comments should be empty', () async {
    const videoUrl = 'https://www.youtube.com/watch?v=A3egPTy9hhA';
    final video = await yt!.videos.get(VideoId(videoUrl));
    final comments = (await yt!.videos.commentsClient.getComments(video))!;
    expect(comments.totalLength, 0);
    expect(comments, isEmpty);
  });

  test('Video with comments disabled should return null', () async {
    const videoUrl = 'https://www.youtube.com/watch?v=jtHb94_MLEE';
    final video = await yt!.videos.get(VideoId(videoUrl));
    final comments = await yt!.videos.commentsClient.getComments(video);
    expect(comments, isNull);
  });
}
