# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.1.0"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-210.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "db28a331f0911370c3e1ed415bb146da89539bf6125546a94b8ef14fdd03970e"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-210.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "a1c97ff4f121e2be69620515443ad3a22fb407ff57f08f07a7926b63457e26b2"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-210.2.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "d10d4aa2daf2afc43397ea4c4106a9965c2930bed022ee4d9e8f195cb856af41"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-210.2.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "338a431ab176662b739e434baf045e5e90fcdff70b6dd540a5b1b90963927a6b"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-210.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "305ca5698e0399bc5cb96c394d158ceb83be59e9dc83b761c2b4dac2769e2af0"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-210.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "070729edebd45adca5f7c023df7b887787452bdc4417682fbbf366712bd7d338"
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
