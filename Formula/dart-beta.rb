# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.18.0-271.2.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-271.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "86397be283f91383e49abcd77b734b3e5349f21c50ab9c65a8098110e041d449"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-271.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "fe2251839fb616e30cf2fa2ef64cdbd6c43b68863bba7b328cc936df81635754"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-271.2.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "e7dbae16bd3ddc185ca275583ba74a94c52ad55f355a75fbf90fbd7c92514265"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-271.2.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "995ab45d0292f9ad993bc1a5e7fc42f6afa94f424b3fb9d6a747ee019f9c9c03"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-271.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "6b5a4e21d821f95e953c64b6a917452b20d81f754073f2aa82304bb09ff99869"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-271.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "511f176418fd4b32380f2be7a3a6086fbf0924fbc9f2c0d20d1ecc15a4a1e5a6"
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
