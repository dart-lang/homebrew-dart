# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.6.0-188.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-188.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "e985b25c4f765dc48849590989bf7beaf3bc68a73f3728254ab3f69b6e018a2e"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-188.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "55f9d0500278869307f4aa7ed239ad0ba74b0e0d3978dd9243ddd32b786097a8"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-188.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "ba6033b3c02c766914c474f597d9a89f423fd6b18d7cfc940dffe7a5085fe99b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-188.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "6b704795bb9129cae9b5df5d26730e9c59c847687135219d8fe35f9cc3a3b372"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-188.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "966b2504f28614e8dfa7cf85a84381d24dc2d59efe6705dd280e7e82d4ad6f61"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-188.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "873d0f9d5ec580e943ed7eb3b027b17c26e0a5a34686258921aff1fd7a052ce2"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "65f00ed58e635574fe69708644c65f2a938034ffd424832cd0a73ec5d63c304c"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "5bbbfd94db56131a5ffbbe106f7d3b15c8bc3436fbf8aaaef32cf28131e1d20c"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "0b50f0523eb1cdaa3c18bcb88f78b4dddfad9e3abced0aef05b0fd765b980d98"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "c43199ade3bca564204f8df3cf63c5194b53003afc5f519660786ac17e932f5b"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "0a382412154fc12ce6dd6d25903281e3c33922b0d3857bc541baea054f09a1f2"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "6be11d8bf7e9f4b9a04ba3169be9af7f407f73c0eee60c0081c5f3871762489c"
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
