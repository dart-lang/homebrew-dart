# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.17.0-266.1.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-266.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "45de2d5ebd47aec9bac37a84b21dc5450e32bcca9598df7dd1e0cecf33b862d9"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-266.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "8eb953c3003ee7f8b6a2385e40d92c6a88603065dae9a3342f05a5445a038afa"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-266.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "afd52527908e2184301873ef2252e13ed3d9938d47acff26297b45376d165e51"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-266.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "f4255dbc8fcae028bf160a6d49c117229bf0f4f5421999853fa333546d74200c"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-266.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "3045035160b0af67111cd28aef5d8cbd50d264deb279d23e77767a0a2137a236"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-266.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "b41216eb894471a3fa6646319f5def4fe7c5115d8be9b664754a7d02a9130c6b"
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
