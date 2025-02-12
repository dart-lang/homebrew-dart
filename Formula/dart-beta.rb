# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.8.0-70.1.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-70.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "dbf203b22ad0e84ef1fa6d9225e2c344822dd01b202c5c9226ab616df115282d"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-70.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "4be1576364b4928d40578dd73fd520c46811e66ccbfc5a2ea28deb3cad144e54"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-70.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "c1b1d66c0fd37a432b268e43b06520b824ada88b268e9e0a3d0e244ba4f3abe4"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-70.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "21c32290b28abcc22296bb994d52a4d2d53d3ba103912e75664a1683e3c7db22"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-70.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "86ce086fb32bceed703e6f460a1c9835aaa421b83ee960d6dfee809d527b5e09"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-70.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "38ccb0abd0f754a7d3b95106cdccd54899a749be7833e49455eadf689941256c"
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
