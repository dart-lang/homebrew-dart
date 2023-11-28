# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.3.0-166.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-166.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "a0548157407f96a1be50dcaf4432155b79bf01cba7d4933efaf1589234f1548f"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-166.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "00fe5d5652e7b87ed5d5ecfb504099282227ed632c7646de8332af8336b9ee0e"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-166.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "7c9b01cbb8e23caae72596a341168b312973ff86481bfb36e890768336ae15c0"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-166.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "78ae578320a7f437d08f916a758b5507a60531195663017620318a8c96bb26fd"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-166.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "5d2cea5163be13c1d25c56bf3c7566b6ea68f2047b6b8d3d218f84914f90d3be"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-166.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "79d9451556cf388a18ad45b4812175a59d0d126f62819386a646ccea0843d190"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "58a63dfd2a15494b6f0f753ea92befbbb86fc793483d0793431f6e569a4981e9"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "6cedb6b3e743ca4c48cfecab48276f5a4e0ffc2a22da320b85faa8216f43f5bf"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "5fbdb0b5a2c2917b48f9cc433942580796630cfa807b25829015d52c60cbb13d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "683850230035a0ac3b1068e4e8f85263db1ac408dd0d504bf0d3ea2ded6b4256"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "3db9be1fc744cae98e45b67418e8cc16e845c0d37351665c6f21f992d9dbc6d8"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "a9ab3f262cee396fbb0b2b20810a0ddc44b8e91e88191c87a3f50c2979db1f64"
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
