// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:args/args.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:update_homebrew/update_homebrew.dart';

void main(List<String> args) async {
  await Chain.capture(() async {
    updateHomeBrew(args);
  }, onError: (error, chain) {
    print(error);
    print(chain.terse);
    exitCode = 1;
  });
}

Future<void> updateHomeBrew(List<String> args) async {
  final parser = ArgParser()
    ..addFlag('dry-run', abbr: 'n')
    ..addOption('revision', abbr: 'r')
    ..addOption('channel', abbr: 'c', allowed: supportedChannels)
    ..addOption('key', abbr: 'k');
  final options = parser.parse(args);
  final dryRun = options['dry-run'] as bool;
  final revision = options['revision'] as String;
  final channel = options['channel'] as String;
  if ([revision, channel].contains(null)) {
    print(
        "Usage: update_homebrew.dart -r version -c channel [-k ssh_key] [-n]\n"
        "  ssh_key should allow pushes to $githubRepo on github");
    exitCode = 64;
    return;
  }

  final repository = Directory.current.path;
  final key = options['key'] as String?;
  final gitEnvironment = <String, String>{};
  if (key != null) {
    final sshWrapper =
        Directory.current.uri.resolve('ssh_with_key').toFilePath();
    gitEnvironment['GIT_SSH'] = sshWrapper;
    gitEnvironment['SSH_KEY_PATH'] = key;
  }
  await writeHomebrewInfo(channel, revision, repository, dryRun);
  await runGit(
      ['commit', '-a', '-m', 'Updated $channel branch to revision $revision'],
      repository,
      gitEnvironment,
      dryRun);
  await runGit(['push'], repository, gitEnvironment, dryRun);
}
