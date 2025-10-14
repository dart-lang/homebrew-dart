# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.10.0-290.2.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-290.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "55c02ffa86b50c08eae558bde666eb850424d2af78dd5486e89d740851c42fe0"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-290.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "20663389d146b89bf253449e0e442efc1d3707f5f2921e7aaed7798724ee6261"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-290.2.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "3d929bedac2129dc2cb43697433452e379be219860b7eb1de1eec5769da6de77"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-290.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "5e8c3f11221cfd87e33590e2aa91a31aa28becd2db0def768ac48478ef6daa62"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-290.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "8003e34c2a00fb6bb6fc35cab1eedf38f9b84a7cf4c0c43876c857eb1ae92a3f"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"].select { |f| File.executable?(f) }
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
