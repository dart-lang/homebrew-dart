// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';
import '../bin/update_homebrew.dart' as bin;

void main() {
  test('dry run', () async {
    await bin
        .updateHomeBrew(['--dry-run', '--revision=2.14.1', '--channel=stable']);
  });
}
