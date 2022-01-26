# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.16.0-134.5.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.16.0-134.5.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "e7f186ed27146a762445f71cae4e14599e3c3f49e5139c6c184ea0de36645019"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.16.0-134.5.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "50266bd1fa14eb1c816ae4417a1def2c8a6fd9ac9c5eabd772b6aff17a58c637"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.16.0-134.5.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "5901beca0d9e87aea07c224f5532003a45c15286c5892018fe09ec077b2662ae"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.16.0-134.5.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "75f8ed9c5dbffd888e64c05abfd9adbe0cc6b4fd7bbbccd87711774cc6f804a8"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.16.0-134.5.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "a708b389d0b7d4864b8189f5d9946888c075a62c359e7559d1585011af31fcc3"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.16.0-134.5.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "e0adf028a6e05703206f58933df1d87e84b50f57cce312a027202422d60f94c7"
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
