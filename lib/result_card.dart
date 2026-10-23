import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:share_plus/share_plus.dart';

import 'app_chrome.dart';
import 'app_theme.dart';
import 'game_board.dart';
import 'game_model.dart';
import 'game_settings.dart';
import 'gameplay_activity.dart';
import 'generated/l10n.dart';
import 'theme_controller.dart';

/// Localized text is captured before rendering, so asynchronous export never
/// depends on a route or BuildContext that may have gone away.
class ResultCardData {
  const ResultCardData({
    required this.model,
    required this.title,
    required this.result,
    required this.mode,
    required this.date,
    required this.blackLabel,
    required this.whiteLabel,
    required this.shareText,
    required this.semanticLabel,
  });

  final GameModel model;
  final String title;
  final String result;
  final String mode;
  final String date;
  final String blackLabel;
  final String whiteLabel;
  final String shareText;
  final String semanticLabel;

  factory ResultCardData.fromContext(BuildContext context, GameModel model,
      GameSettings settings, DateTime playedAt) {
    final s = S.of(context);
    final tie = model.blackScore == model.whiteScore;
    final blackWins = model.blackScore > model.whiteScore;
    final humanWins = blackWins == (settings.humanColor == PieceType.black);
    final result = tie
        ? s.Tie
        : settings.twoPlayerMode
            ? blackWins
                ? s.BlackWins
                : s.WhiteWins
            : humanWins
                ? s.YouWin
                : s.YouLose;
    final mode = settings.isDailyChallenge
        ? s.DailyChallenge
        : settings.twoPlayerMode
            ? s.TwoPlayersMode
            : settings.difficulty.label(context);
    final date = DateFormat.yMMMd(Localizations.localeOf(context).toString())
        .format(playedAt.toLocal());
    final score = s.SavedMatchScore(model.blackScore, model.whiteScore);
    return ResultCardData(
      model: model,
      title: s.Classic_Reversi,
      result: result,
      mode: mode,
      date: date,
      blackLabel: s.Black,
      whiteLabel: s.White,
      shareText:
          s.ShareResult(result, model.blackScore, model.whiteScore, mode),
      semanticLabel: s.ResultCardPreviewLabel(result, score, mode, date),
    );
  }
}

/// Draw a standalone, opaque 1080×1600 PNG. Its composition is independent of
/// device orientation and text-scale settings; the preview retains a complete
/// screen-reader description of the image.
Future<Uint8List> renderResultCard(ResultCardData data, AppTheme theme) async {
  const width = 1080.0;
  const height = 1600.0;
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  const bounds = Rect.fromLTWH(0, 0, width, height);
  canvas.drawRect(
      bounds,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [theme.backgroundStart, theme.backgroundFinish],
        ).createShader(bounds));
  canvas.drawRRect(
    RRect.fromRectAndRadius(bounds.deflate(24), const Radius.circular(38)),
    Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = theme.lastMoveBorder.withValues(alpha: 0.42),
  );

  void text(String value, double y, double size,
      {double maxHeight = 100,
      Color color = Colors.white,
      FontWeight weight = FontWeight.w500}) {
    var fontSize = size;
    late TextPainter painter;
    while (true) {
      painter = TextPainter(
        text: TextSpan(
            text: value,
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: fontSize,
                fontWeight: weight,
                color: color,
                height: 1.2)),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: 920);
      if (painter.height <= maxHeight || fontSize <= 16) break;
      painter.dispose();
      fontSize *= 0.9;
    }
    painter.paint(canvas, Offset((width - painter.width) / 2, y));
    painter.dispose();
  }

  text(data.title, 58, 44,
      maxHeight: 65, color: theme.lastMoveBorder, weight: FontWeight.w600);
  text(data.result, 138, 70, maxHeight: 135, weight: FontWeight.w700);
  text(data.mode, 278, 34, maxHeight: 78);
  text(data.date, 355, 28, maxHeight: 42, color: const Color(0xD9FFFFFF));

  const frame = Rect.fromLTWH(72, 420, 936, 936);
  canvas.drawRRect(
    RRect.fromRectAndRadius(
        frame.shift(const Offset(0, 16)), const Radius.circular(32)),
    Paint()..color = const Color(0x77000000),
  );
  canvas.drawRRect(
      RRect.fromRectAndRadius(frame, const Radius.circular(32)),
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.boardFrameLight,
            theme.boardFrameMid,
            theme.boardFrameDark
          ],
        ).createShader(frame));
  canvas.drawRRect(
      RRect.fromRectAndRadius(frame, const Radius.circular(32)),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..color = theme.boardFrameHighlight.withValues(alpha: 0.65));
  const board = Rect.fromLTWH(90, 438, 900, 900);
  final cell = board.width / data.model.board.size;
  canvas.save();
  canvas.clipRRect(RRect.fromRectAndRadius(board, const Radius.circular(16)));
  for (var y = 0; y < data.model.board.size; y++) {
    for (var x = 0; x < data.model.board.size; x++) {
      final rect = Rect.fromLTWH(
          board.left + x * cell, board.top + y * cell, cell, cell);
      canvas.drawRect(
          rect,
          Paint()
            ..shader = LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [theme.boardSurfaceLight, theme.boardSurfaceDark],
            ).createShader(rect));
      canvas.drawRect(
          rect.deflate(1),
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2
            ..color = theme.boardGrooveDark.withValues(alpha: 0.5));
      final piece = data.model.board.getPieceAtLocation(x, y);
      if (piece == PieceType.empty) continue;
      final center = rect.center;
      final radius = cell * 0.38;
      canvas.drawCircle(center + Offset(0, cell * 0.06), radius,
          Paint()..color = const Color(0x77000000));
      final disc = Rect.fromCircle(center: center, radius: radius);
      canvas.drawCircle(center, radius,
          Paint()..shader = theme.pieceGradients[piece]!.createShader(disc));
      canvas.drawCircle(
          center,
          radius,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2
            ..color = piece == PieceType.black
                ? const Color(0xFF626467)
                : const Color(0xFFFAF8F0));
      canvas.drawArc(
          disc.deflate(radius * 0.09),
          math.pi * 1.08,
          math.pi * 0.74,
          false,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = cell * 0.025
            ..strokeCap = StrokeCap.round
            ..color = const Color(0x55FFFFFF));
    }
  }
  canvas.restore();
  text(
      '${data.blackLabel} ${data.model.blackScore}   ·   '
      '${data.whiteLabel} ${data.model.whiteScore}',
      1400,
      46,
      maxHeight: 115,
      weight: FontWeight.w700);
  text(data.title, 1530, 26, maxHeight: 40, color: theme.lastMoveBorder);

  final picture = recorder.endRecording();
  final image = await picture.toImage(width.toInt(), height.toInt());
  picture.dispose();
  try {
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    if (bytes == null) throw StateError('PNG encoding failed');
    return bytes.buffer.asUint8List();
  } finally {
    image.dispose();
  }
}

typedef ResultShareAction = Future<ShareResult> Function(ShareParams params);

Future<ShareResult> _nativeShare(ShareParams params) =>
    SharePlus.instance.share(params);

Future<void> showResultCard(
  BuildContext context, {
  required GameModel model,
  required GameSettings settings,
  DateTime? playedAt,
  AppTheme? theme,
  ResultShareAction? shareAction,
}) {
  final data = ResultCardData.fromContext(
      context, model, settings, playedAt ?? DateTime.now());
  final palette = theme ?? ThemeController.instance.theme;
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: palette.backgroundFinish,
    constraints: const BoxConstraints(maxWidth: 640),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (context) => _ResultCardSheet(
        data: data, theme: palette, shareAction: shareAction ?? _nativeShare),
  );
}

class _ResultCardSheet extends StatefulWidget {
  const _ResultCardSheet(
      {required this.data, required this.theme, required this.shareAction});
  final ResultCardData data;
  final AppTheme theme;
  final ResultShareAction shareAction;

  @override
  State<_ResultCardSheet> createState() => _ResultCardSheetState();
}

class _ResultCardSheetState extends State<_ResultCardSheet> {
  late Future<Uint8List> _image;
  bool _sharing = false;

  @override
  void initState() {
    super.initState();
    GameplayActivity.begin(this);
    _image = renderResultCard(widget.data, widget.theme);
  }

  @override
  void dispose() {
    GameplayActivity.end(this);
    super.dispose();
  }

  Future<void> _share(Uint8List bytes) async {
    if (_sharing) return;
    setState(() => _sharing = true);
    try {
      final box = context.findRenderObject() as RenderBox?;
      await widget.shareAction(ShareParams(
        text: widget.data.shareText,
        files: [
          XFile.fromData(bytes,
              mimeType: 'image/png', name: 'classic-reversi.png')
        ],
        fileNameOverrides: const ['classic-reversi.png'],
        sharePositionOrigin:
            box == null ? null : box.localToGlobal(Offset.zero) & box.size,
      ));
    } catch (error) {
      debugPrint('Result sharing failed: $error');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).ResultCardShareFailed)));
      }
    } finally {
      if (mounted) setState(() => _sharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.9,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(children: [
              Expanded(
                  child: Text(s.ResultCardTitle, style: AppChrome.titleStyle)),
              IconButton(
                  tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(CupertinoIcons.xmark, color: Colors.white)),
            ]),
            const SizedBox(height: 16),
            FutureBuilder<Uint8List>(
                future: _image,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Column(children: [
                      Text(s.ResultCardError, style: AppChrome.bodyStyle),
                      const SizedBox(height: 12),
                      TextButton(
                          onPressed: () => setState(() => _image =
                              renderResultCard(widget.data, widget.theme)),
                          child: Text(s.TryAgain)),
                    ]);
                  }
                  if (!snapshot.hasData) {
                    return SizedBox(
                        height: 180,
                        child: Center(
                            child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CircularProgressIndicator(),
                            const SizedBox(height: 16),
                            Text(s.ResultCardPreparing,
                                style: AppChrome.bodyStyle),
                          ],
                        )));
                  }
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                            height: math.min(
                                MediaQuery.sizeOf(context).height * 0.58, 540),
                            child: Image.memory(snapshot.data!,
                                fit: BoxFit.contain,
                                semanticLabel: widget.data.semanticLabel)),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed:
                              _sharing ? null : () => _share(snapshot.data!),
                          style: appPrimaryButtonStyle(widget.theme),
                          icon: _sharing
                              ? const SizedBox.square(
                                  dimension: 18,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2))
                              : const Icon(CupertinoIcons.share),
                          label: Text(s.Share),
                        ),
                      ]);
                }),
          ],
        ),
      ),
    );
  }
}
