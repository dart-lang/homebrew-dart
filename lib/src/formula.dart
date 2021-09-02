// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

String updateFormula(String channel, String contents, String version,
    Map<String, String> hashes) {
  // Replace the version identifier. Formulas with stable and pre-release
  // versions have multiple identifiers and only the right one should be
  // updated.
  var versionId = channel == 'stable'
      ? RegExp(r'version \"\d+\.\d+.\d+\"')
      : RegExp(r'version \"\d+\.\d+.\d+\-.+\"');
  contents = contents.replaceAll(versionId, 'version "$version"');

  // Extract files and hashes that are stored in the formula in this format:
  //  url "<url base>/<channel>/release/<version>/sdk/<artifact>.zip"
  //  sha256 "<hash>"
  var filesAndHashes = RegExp(
      'channels/$channel/release'
      r'/(\d[\w\d\-\.]*)/sdk/([\w\d\-\.]+)\"\n(\s+)sha256 \"[\da-f]+\"',
      multiLine: true);
  return contents.replaceAllMapped(filesAndHashes, (m) {
    var currentVersion = m.group(1);
    if (currentVersion == version) {
      throw ArgumentError(
          'Channel $channel is already at version $version in homebrew.');
    }
    var artifact = m.group(2);
    var indent = m.group(3);
    return 'channels/$channel/release/$version/sdk/$artifact"\n'
        '${indent}sha256 "${hashes[artifact]}"';
  });
}
