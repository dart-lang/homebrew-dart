# Dart for Homebrew

This is the official [Dart][] tap for [homebrew][].

Mac users can use these formulae to easily install and update Dart SDK and
Dartium. Both dev and stable channels are supported.

## Initial setup

If you don't have homebrew, install it from their [homepage][homebrew].

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
brew linkapps
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

[homebrew]: http://brew.sh/
[dart]: https://www.dartlang.org
