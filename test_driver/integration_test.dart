import 'dart:convert';
import 'dart:io';

import 'package:integration_test/integration_test_driver.dart';

/// Writes the PNGs reported by integration_test/mac_store_screenshots_test.dart
/// to `SCREENSHOTS_DIR` (default build/mac_store_screenshots).
Future<void> main() => integrationDriver(
      responseDataCallback: (data) async {
        final out = Directory(Platform.environment['SCREENSHOTS_DIR'] ??
            'build/mac_store_screenshots')
          ..createSync(recursive: true);
        for (final entry in (data ?? const {}).entries) {
          final file = File('${out.path}/${entry.key}.png');
          file.writeAsBytesSync(base64Decode(entry.value as String));
          stdout.writeln('wrote ${file.path}');
        }
      },
    );
