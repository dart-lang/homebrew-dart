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

For web developers, we highly recommend Dartium:

```
brew install dartium
brew linkapps
```

Installing Dartium using Homebrew will also install Dartium Content Shell.
You can then run Content Shell using `content_shell`.

## Updating

Simply run:

```
brew update
brew upgrade dart dartium
```

[homebrew]: http://brew.sh/
[dart]: https://www.dartlang.org
