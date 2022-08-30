# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.19.0-146.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-146.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "188054c964a1d1ef6caba6133df0b7c805deafac560de16ca46826093f3cc187"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-146.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "c5ab3bea345d2bbf62268914984d6cf04ea08f1a7a0f73e8e5e1aa8be8f2827b"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-146.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "688f8b5238632f53f6cbddee7ded17c665dccb00fb639ccab32a43437f18a4c8"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-146.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "f2201cb96f617b0b9da5f7daaad0086b8aa3db9ad18baec5d575689b090a1737"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-146.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "86c628337919bf7802a8551ce338046a95035dd7f075363811576e2828a0d415"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-146.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "8dd39c4ae3ab4f98c3022b8392d37c121ec7cb9f60eb3a090b03958bf6263236"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.7/sdk/dartsdk-macos-x64-release.zip"
    sha256 "ba258fff40822cb410c4f1f7916b63f0837903a6bae8f4bd83341053b10ecbe3"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.7/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "a4be379202cf731c7e33de20b4abc4ca1e2e726bc5973222b3a7ae5a0cabfce1"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.7/sdk/dartsdk-linux-x64-release.zip"
      sha256 "ba8bc85883e38709351f78c527cbf72e22cd234b3678a1ec6a2e781f7984e624"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.7/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "6a4ebb50bd2e3a687dffc88640ac8452cfc713bb84601c45869f04c5aa2dd056"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.7/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "ee0acf66e184629b69943e9f29459e586095895c6aae6677ab027d99c00934b6"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.7/sdk/dartsdk-linux-arm-release.zip"
      sha256 "701de8f09d92abadbee8773828c40f52a173fe5eae378d3bf84fd6becb9242f4"
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
