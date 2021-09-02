// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart';
import 'package:googleapis/storage/v1.dart' as storage;
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

import 'src/formula.dart';

part 'src/impl.dart';

const githubRepo = 'dart-lang/homebrew-dart';

const formulaByChannel = {
  'beta': 'Formula/dart-beta.rb',
  'dev': 'Formula/dart.rb',
  'stable': 'Formula/dart.rb'
};

Iterable<String> get supportedChannels => formulaByChannel.keys;

Future<void> writeHomebrewInfo(
    String channel, String version, String repository) async {
  var formula = File(p.join(repository, formulaByChannel[channel]));
  var contents = await formula.readAsString();
  var hashes = await _getHashes(channel, version);
  var updated = updateFormula(channel, contents, version, hashes);
  await formula.writeAsString(updated, flush: true);
}

Future<void> runGit(List<String> args, String repository,
    Map<String, String> gitEnvironment) async {
  print("git ${args.join(' ')}");

  var result = await Process.run('git', args,
      workingDirectory: repository, environment: gitEnvironment);

  print(result.stdout);
  print(result.stderr);
}
