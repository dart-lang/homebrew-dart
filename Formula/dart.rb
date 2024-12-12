# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.7.0-232.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-232.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "84eeb56e342fa0d01826f54f207811a6340d42cc020ab029a1d2462bcd0db460"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-232.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "2efa1256513957c2e7f53dc36ee4801683edd438757d234f9f02b193c82947e9"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-232.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "d1b29b1ea2523da8dda49a1f6b3ecef093c4cd8bd5eca688033c907619d5154d"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-232.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "f99c9724111e80d71a02e38ee43cfeec4153c8429c13eddc120655127afd7040"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-232.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "da36c36ed0cf3fa075f8495c569bb7c4c0cf013da732a5f38e69bb21a7bd5bc2"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-232.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "28a7bb58b55a6552548b288edb1a78b06b879fbe792c0a5d32836c6cfc84a276"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "b859b1abd92997b389061be6b301e598a3edcbf7e092cfe5b8d6ce2acdf0732b"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "1bdbc6544aaa53673e7cbbf66ad7cde914cb7598936ebbd6a4245e1945a702a0"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "8e14ff436e1eec72618dabc94f421a97251f2068c9cc9ad2d3bb9d232d6155a3"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "7c8fe91f6ca9f7b2f8216a34e49e9963b38fea8cda77db9ee96f419ec19f114d"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "0f82f10f808c7003d0d03294ae9220b5e0824ab3d2d19b4929d4fa735254e7bf"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "7281158159d65d35d0bee46a97eb425f3efcb53ca3e52fd4901aac47da8af3fc"
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
