# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.19.0-444.2.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-444.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "c37c44de0f0d38585b46c901e97108d5d64eaa75f6a4b38ba449bd1b33b9d410"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-444.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "5b5fbb3a4e48532d226824738c4793dffd3b1aecc51ad94dc28e3b01e9422842"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-444.2.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "9454bfc7eeab61dd7d9b13a393c0c2978ee5a71a2059c687b1b2e8e31eef6740"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-444.2.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "1a888b91c0c3d6da94b516ba65b7ec01796dc1a9dc2a582a0508787bba01a105"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-444.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "b03f47f26373873643e7e7ce85fad3b6fe0220d1707be774288e9b4f1d9beddf"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-444.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "8b6d06901fda8603e9d0f91224f8d376ff10079a28491be33d84f5c9fbce816d"
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
