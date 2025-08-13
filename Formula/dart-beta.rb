# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.10.0-75.1.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-75.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "4cf216406fb5cfc84eb7d3987b23124abacc178d680e0c18d6b52a12d1c3ca7d"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-75.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "9d81628797558473459ac2ccbf35264609d8a0b89456e9d9357329dccd5f07de"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-75.1.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "6611ef00903d500efd0bc74a910b01c818ed5c685f77b980c505b8a1b03f8c53"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-75.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "313fbe03e064742ddac0f46c78b0a1c5e1e51c5040cc447e0c17b54885f77f51"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-75.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "c878444a937d23344b9bcb95a052a3b2c2709e51369a88b4bcf6edbadfc070df"
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
