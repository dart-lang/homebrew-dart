class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"

  version "2.10.2"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "eb51f670ee184887b56e7432501fc16a3fadcbab45fb1ee633055b093b54f81a"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "fa98052d7fa605807a6b34ccc00f133da82e6d23c3e7f7663dfd32b121246c25"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "aa42fbf63f8c069689ac7ec6c030bae2b1071079f8cbb0792db35271a68e0ea1"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "152eb0f57860de934cb2201171ba41ddf2c68c130ad554d13b535bcce1a03b87"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "0ff43c7858cf0df8538ece913e14118f81022248c3ab7c6a7486ca2de4c146af"
    end
  end

  head do
    version "2.11.0-240.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-240.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "251c5bbee39f05d7ba5b742731b39c99ae80148376b854e938491b9073b05fdb"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-240.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "777a822012737110066a4395e3196936d67c23671e958c008ac5af491308c735"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-240.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "3dd1b2e2a0cfac8ef92066c826b309d8f0913f0a5660dd5a1e10f6119f7a8cd4"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-240.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "336b7e06ba3ed19e50fb8d0ac3ec199d0f4ff629382d34bdc1805aea64835178"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-240.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "64d136120f9d46cf73b7ea929e264a9bfad722e2cddcf824e7e9423afc2e2d87"
      end
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
