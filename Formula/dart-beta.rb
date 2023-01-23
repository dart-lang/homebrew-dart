# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.19.0-444.6.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-444.6.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "cc34373975a13a504b370f9ce1770e6d925a1fc038f5842abda6d9897074cc4b"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-444.6.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "4bae4c8492779ef5471ed5c5b03ff23da469d25a85df352f3fa4ffb88477b770"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-444.6.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "5d53a4966ca90b115ee967b198e780c37716fbde9a9a692ad54d1620213caaed"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-444.6.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "14f7e6b9b9874d766342e6fe7207c699c118168aa7eb7b538c7ccc65d75c22fe"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-444.6.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "4e66f4a4609412eb057c42334e976f1d83a579771fceef3c42ac906ca268816c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-444.6.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "fe29b1c10519d2832dfe9458bb7e694535656401640d4d3124e5db225d0b28a6"
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
