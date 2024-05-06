# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.4.0-282.4.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-282.4.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "486744c9e0f8e16e761decaf66c29012b73ead2cf174d508661b6aa4c967a23a"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-282.4.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "99c1916b9284ace05c91a71bcebb3bdb35d140e286a5eb318b1ab033afe7c29b"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-282.4.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "750b5b5ef1e7f051b8c62d7d54aaec8cc85a9997317ec6f3cb5c181b6b4ab947"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-282.4.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "16f8a623098695235b855773934b72238505d0020dcd2b0d6be925a370b545c4"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-282.4.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "b11db09d5734aa3df5ce11c3cfb27918815a6b75127fef6bcdee8dfb8f922c5f"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-282.4.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "93e9490f7293559958788e7d414e16cd9e552d2a4f6c294a0b96026a3833574c"
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
