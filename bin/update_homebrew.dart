// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:http/http.dart';
import 'package:http/retry.dart';
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
    ..addMultiOption('channel',
        abbr: 'c', allowed: supportedChannels, defaultsTo: supportedChannels);

  final options = parser.parse(args);
  final dryRun = options['dry-run'] as bool;
  final revisionOption = options['revision'] as String?;
  final channels = options['channel'] as List<String>;
  if (revisionOption != null && channels.length != 1) {
    throw Exception('-r requires a singular channel set with -c');
  }
  for (final channel in channels) {
    final revision = revisionOption ?? await getLatestVersion(channel);
    await updateVersion(revision, channel, dryRun);
  }
}

Future<void> updateVersion(String revision, String channel, bool dryRun) async {
  final repository = Directory.current.path;
  if (await writeHomebrewInfo(channel, revision, repository, dryRun)) {
    await runGit(
        ['commit', '-a', '-m', 'Updated $channel channel to version $revision'],
        repository,
        null,
        dryRun);
  } else {
    print('Channel $channel is up to date at version $revision');
  }
}

Future<String> getLatestVersion(String channel) async {
  final uri = Uri.parse('https://storage.googleapis.com/'
      'dart-archive/channels/$channel/release/latest/VERSION');
  final client = RetryClient(Client());
  try {
    return jsonDecode(await client.read(uri))['version'];
  } finally {
    client.close();
  }
}
