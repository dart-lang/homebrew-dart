# Dart for Homebrew

This is the official [Dart][] tap for [Homebrew][].

Mac users can use these formulae to easily install and update Dart SDK and
Dartium. Both dev and stable channels are supported.

## Initial setup

If you don't have Homebrew, install it from their [homepage][homebrew].

Then, add this tap:

```
brew tap dart-lang/dart
```

## Installing

To install the Dart SDK:

```
brew install dart
```

Tip: Once installed, homebrew will print the path to the Dart SDK. Use this path to configure Dart support
in your IDE (like WebStorm).

For web developers, we highly recommend Dartium and content shell:

```
brew install dart --with-dartium --with-content-shell
```

To install Dartium to your Applications:

```
ditto /usr/local/opt/dart/Chromium.app/ /Applications/Dartium.app/
```

## Dev Releases

To install dev channel releases, instead of the stable ones, add a `--devel`
flag after the brew commands:

```shell
brew install dart --devel
```

## Updating

Simply run:

```
brew update
brew upgrade dart
```

## Dart 2 Migration

This tap provides versioned `dart@1` and `dart@2` formulae to assist with the migration to the new major Dart 2 release.

Use `dart@2` in your formula dependencies if you are an application developer and your current version requires Dart 2. Note that this is a temporary measure; once a stable Dart 2.x release is out, the `dart@2` formula will be removed and you can go back to using the regular `dart` dependency.

Use `dart@1` in formulae for legacy applications which are not compatible with Dart 2.


[Homebrew]: http://brew.sh/
[dart]: https://www.dartlang.org
