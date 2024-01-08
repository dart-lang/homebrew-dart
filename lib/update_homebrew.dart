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

const formulaByChannel = {
  'dev': 'Formula/dart.rb',
  'beta': 'Formula/dart-beta.rb',
  'stable': 'Formula/dart.rb'
};

Iterable<String> get supportedChannels => formulaByChannel.keys;

Future<bool> writeHomebrewInfo(String channel, String version,
    String repository, bool dryRun, bool isLatest) async {
  final versionedFormula = File(p.join(repository, 'Formula/dart@$version.rb'));
  if (!isLatest && versionedFormula.existsSync()) {
    return false;
  }
  final formula = File(p.join(repository, formulaByChannel[channel]));
  final contents = await formula.readAsString();
  final hashes = await _getHashes(channel, version);
  final updated = updateFormula(channel, contents, version, hashes);
  bool changed = false;
  if (isLatest && contents != updated) {
    changed = true;
    if (dryRun) {
      print('Writing $formula');
    } else {
      await formula.writeAsString(updated, flush: true);
    }
  }
  if (channel == 'stable') {
    if (await writeVersion(updated, version, repository, dryRun, isLatest)) {
      changed = true;
    }
  }
  return changed;
}

Future<bool> writeVersion(String contents, String version, String repository,
    bool dryRun, bool isLatest) async {
  final formula = File(p.join(repository, 'Formula/dart@$version.rb'));
  contents = contents
      .replaceFirst('class Dart', 'class DartAT${version.replaceAll(".", "_")}')
      .replaceFirst(
          RegExp(r'head do.*dart-beta ships the same binaries"',
              dotAll: true, multiLine: true),
          'keg_only :versioned_formula');
  if (!await formula.exists() ||
      (isLatest && await formula.readAsString() != contents)) {
    if (dryRun) {
      print('Writing $formula');
    } else {
      await formula.writeAsString(contents, flush: true);
    }
    return true;
  }
  return false;
}

Future<void> runGit(List<String> args, String repository,
    Map<String, String>? gitEnvironment, bool dryRun) async {
  if (dryRun) {
    args = [args[0], '--dry-run', ...args.skip(1)];
  }
  print("git ${args.join(' ')}");

  final result = await Process.run('git', args,
      workingDirectory: repository, environment: gitEnvironment);

  if (result.stdout != "") {
    print(result.stdout.trimRight());
  }
  if (result.stderr != "") {
    print(result.stderr.trimRight());
  }

  if (result.exitCode != 0 && !dryRun /* the test doesn't write a file */) {
    throw Exception("Command exited ${result.exitCode}: git ${args.join(' ')}");
  }
}

bool isModernVersion(String version) => 3 <= int.parse(version.split('.')[0]);

bool isNewerStableVersion(String a, String b) {
  final aMajor = int.parse(a.split('.')[0]);
  final aMinor = int.parse(a.split('.')[1]);
  final aPatch = int.parse(a.split('.')[2]);
  final bMajor = int.parse(b.split('.')[0]);
  final bMinor = int.parse(b.split('.')[1]);
  final bPatch = int.parse(b.split('.')[2]);
  return aMajor < bMajor ||
      (aMajor == bMajor &&
          (aMinor < bMinor || (aMinor == bMinor && aPatch < bPatch)));
}
