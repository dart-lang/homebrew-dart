// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:update_homebrew/update_homebrew.dart';
import '../bin/update_homebrew.dart' as bin;

void main() {
  test('dry run', () async {
    await bin.updateHomeBrew([
      '--dry-run',
      '--revision=2.14.1',
      '--channel=stable',
    ]);
  });

  test('valid version validation', () {
    final validVersions = [
      '3.5.0',
      '3.12.2',
      '3.6.0-123.0.dev',
      '3.13.0-167.1.beta',
      '2.19.6',
    ];
    for (final version in validVersions) {
      expect(
        versionRegExp.hasMatch(version),
        isTrue,
        reason: 'Expected $version to be valid',
      );
    }
  });

  test('invalid version rejection', () {
    final invalidVersions = [
      '3.99.0 < Formula; end; system %(echo payload); class Z',
      '3.99.0-x";system("echo payload");"',
      '3.0X0',
      '3.0.0\nputs "injection"',
      'invalid/3.0.0/path',
      '3.0.0; rm -rf /',
    ];
    for (final version in invalidVersions) {
      expect(
        versionRegExp.hasMatch(version),
        isFalse,
        reason: 'Expected $version to be rejected',
      );
    }
  });
}
