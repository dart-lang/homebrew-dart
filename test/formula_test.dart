// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:update_homebrew/src/formula.dart';

const _devFormula = '''
  head do
    version "2.15.0-65.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-65.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "9c71429a806dd2ac7968542771764dd5d1b7c71fd03851c6870eb5c3f687fb1b"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-65.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "754521d866bf2e878d2b4a33be96ece27a6381aa4b73a397d0b349bdd87b4eaa"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-65.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "af6537fe9b248f704420e05a88eedb0b2b0db9c8f3e996da90aabd2037543286"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-65.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "a19f58988af2098a8f7ae4996fa25f95a86d43188fd0a796cc3740a5eeb2a855"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-65.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "e9f3bc610cea89c972a85767d86ab424cce6cab46e3da4065cfdd1aadfc43bef"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-65.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "71da750dd2e78970b69c3b2cb388527d7a1ccd70ea8e8cacb5bba191841effa0"
      end
    end
  end
''';

const _devFormulaExpected = '''
  head do
    version "2.16.0-76.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-76.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "bbb"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-76.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "aaa"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-76.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "ccc"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-76.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "eee"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-76.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "ddd"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-76.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "fff"
      end
    end
  end
''';

main() {
  test('update dev formula', () {
    var hashes = {
      'dartsdk-macos-arm64-release.zip': 'aaa',
      'dartsdk-macos-x64-release.zip': 'bbb',
      'dartsdk-linux-x64-release.zip': 'ccc',
      'dartsdk-linux-arm64-release.zip': 'ddd',
      'dartsdk-linux-ia32-release.zip': 'eee',
      'dartsdk-linux-arm-release.zip': 'fff',
    };
    var updated = updateFormula('dev', _devFormula, '2.16.0-76.0.dev', hashes);
    expect(updated, _devFormulaExpected);
  });
}
