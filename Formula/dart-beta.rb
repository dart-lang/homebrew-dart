# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.14.0-377.7.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-377.7.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "34e0f9af9a45a122b6a3618c3e0f9822e57f09300ca0839b2c4f7138ac476287"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-377.7.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "dbb2a28b2d3f645171d614d387add13be17b156b09cc20398f2fecf2369accce"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-377.7.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "331004e674ebc9bdd4bb91b238fbd0190fcaae0e9205c8d85e6257ef60d4fabf"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-377.7.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "b9d1b90beabe7806d894a5a9293efefaebaa873bce13c73efd82252f4a6a2e15"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-377.7.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "ce27c85e35e2622be05477940f1e33308d8594c4c31493dd1dd0c5902198f982"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-377.7.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "b357d5615ab2c55eaba51712d1989a88e335944c6221c00a6e7449990bc466fd"
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
