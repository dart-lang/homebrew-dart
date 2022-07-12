# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.18.0-271.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-271.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "e6037110460a6f782d929f0ab980256a56d934d223d3bf67dca19175e855dc51"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-271.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "1c0f95826c6b50d60e6717b4c553d277cbc9904fa352edee591bd4929862d025"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-271.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "d507faf120db2b4949e750800d38b39a088df98319c095cfb7e7351431d3cb92"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-271.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "0b5fc8801c6dc7e562b1e815603f9dff4754561f621984f7177e2920a611deeb"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-271.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "cdfbf3bdffde243951ae6ba7b431df0e4a5a5c0496dcc34343534de14949b444"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-271.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "9c97a0fc1b5a2b769fc7ee3abd6dba9e8ddc68fd265e0a77ae53f818513ef262"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.5/sdk/dartsdk-macos-x64-release.zip"
    sha256 "55e2ffe2ddbcef88e7a7fcb87348ff10934234f0ecbd9b463316018e8bb7d8a8"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.5/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "ca0c0df7085465a616b86919fa66440632aedfd7a26cda16f3412421f8e6ee96"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.5/sdk/dartsdk-linux-x64-release.zip"
      sha256 "0052467a23ec8d46523be0f29263881444e0da3228860eb6b69de0859aca2459"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.5/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "26dd57fd191638196374bc77059a988b5510d7cb169d3032a2bde47ccc4f1957"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.5/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "0482ba914c7e9befc67d1ff0057bfcae354d6cfeb0d4716f1ff44623089a2688"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.5/sdk/dartsdk-linux-arm-release.zip"
      sha256 "00e855429cd7345a56235a7b216967d23c22d0c1a0417249c4323b1cbfe9af62"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"]
  end

  def caveats
    <<~EOS
      Please note the path to the Dart SDK:
        #{opt_libexec}
    EOS
  end

  test do
    (testpath/"sample.dart").write <<~EOS
      void main() {
        print(r"test message");
      }
    EOS

    assert_equal "test message\n", shell_output("#{bin}/dart sample.dart")
  end
end
