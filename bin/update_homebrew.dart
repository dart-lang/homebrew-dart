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
    ..addFlag('no-commit')
    ..addOption('revision', abbr: 'r')
    ..addMultiOption('channel',
        abbr: 'c', allowed: supportedChannels, defaultsTo: supportedChannels);

  final options = parser.parse(args);
  final dryRun = options['dry-run'] as bool;
  final noCommit = options['no-commit'] as bool;
  final channels = options['channel'] as List<String>;
  for (final channel in channels) {
    final latest = await getLatestVersion(channel);
    final versions = channel == 'stable'
        ? (await getVersions(channel)).where(isModernVersion)
        : [latest];
    for (final version in versions) {
      await updateVersion(
          version, channel, dryRun, noCommit, version == latest);
    }
  }
}

Future<void> updateVersion(String version, String channel, bool dryRun,
    bool noCommit, bool isLatest) async {
  final repository = Directory.current.path;
  if (await writeHomebrewInfo(channel, version, repository, dryRun, isLatest)) {
    if (channel == 'stable') {
      final majorMinor = version.split('.').take(2).join('.');
      final newFormula = 'Formula/dart@$version.rb';
      if (!noCommit) {
        await runGit(['add', newFormula], repository, null, dryRun);
      }
      final alias = Link('Aliases/dart@$majorMinor');
      if (!alias.existsSync() ||
          isNewerStableVersion(
              alias
                  .targetSync()
                  .replaceAll('../Formula/dart@', '')
                  .replaceAll('.rb', ''),
              version)) {
        if (alias.existsSync() && !dryRun) {
          alias.deleteSync();
        }
        print('Symlinked ${alias.path} to ../$newFormula');
        if (!dryRun) {
          alias.createSync('../$newFormula');
        }
        if (!noCommit) {
          await runGit(['add', alias.path], repository, null, dryRun);
        }
      }
    }
    final message = 'Updated $channel channel to version $version';
    if (!noCommit) {
      await runGit(['commit', '-a', '-m', message], repository, null, dryRun);
    } else {
      print(message);
    }
  } else if (isLatest) {
    print('Channel $channel is up to date at version $version');
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

Future<List<String>> getVersions(String channel) async {
  final versionRegExp = RegExp(r'\d+\.\d+.\d+(-.+)?');
  final uri = Uri.parse('https://storage.googleapis.com/'
      'storage/v1/b/dart-archive/o?delimiter=%2F&alt=json&'
      'prefix=channels%2F$channel%2Frelease%2F');
  final client = RetryClient(Client());
  try {
    return (jsonDecode(await client.read(uri))['prefixes'] as List<dynamic>)
        .cast<String>()
        .map((path) => path.split('/')[3])
        .where((version) => versionRegExp.hasMatch(version))
        .toList();
  } finally {
    client.close();
  }
}
