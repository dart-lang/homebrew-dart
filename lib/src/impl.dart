// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of '../update_homebrew.dart';

const _files = [
  'dartsdk-macos-arm64-release.zip',
  'dartsdk-macos-x64-release.zip',
  'dartsdk-linux-x64-release.zip',
  'dartsdk-linux-arm64-release.zip',
  'dartsdk-linux-arm-release.zip',
];

Future<String> _getHash256(
    String channel, String version, String download) async {
  var client = http.Client();
  try {
    var api = storage.StorageApi(client);
    var url = 'channels/$channel/release/$version/sdk/$download.sha256sum';
    var media = await api.objects.get('dart-archive', url,
        downloadOptions: DownloadOptions.fullMedia) as Media;
    var hashLine = await ascii.decodeStream(media.stream);
    return RegExp('[0-9a-fA-F]*').stringMatch(hashLine)!;
  } finally {
    client.close();
  }
}

Future<Map<String, String>> _getHashes(String channel, String version) async {
  return <String, String>{
    for (var file in _files) file: await _getHash256(channel, version, file)
  };
}
