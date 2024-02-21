// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

String updateFormula(String channel, String contents, String version,
    Map<String, String> hashes) {
  // Replace the version identifier. Formulas with stable and pre-release
  // versions have multiple identifiers and only the right one should be
  // updated.
  final versionId = RegExp(r'version \"\d+\.\d+.\d+(-[^"]+)?\" # ' + channel);
  contents = contents.replaceAll(versionId, 'version "$version" # $channel');

  // Extract files and hashes that are stored in the formula in this format:
  //  url "<url base>/<channel>/release/<version>/sdk/<artifact>.zip"
  //  sha256 "<hash>"
  final filesAndHashes = RegExp(
      'channels/$channel/release'
      r'/\d[\w\d\-\.]*/sdk/([\w\d\-\.]+)\"\n(\s+)sha256 \"[\da-f]+\"',
      multiLine: true);
  return contents.replaceAllMapped(filesAndHashes, (m) {
    final artifact = m.group(1);
    final indent = m.group(2);
    return 'channels/$channel/release/$version/sdk/$artifact"\n'
        '${indent}sha256 "${hashes[artifact]}"';
  });
}
