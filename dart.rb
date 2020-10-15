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
    version "2.11.0-213.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-213.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "99959a2c823e9523bef7a9811753b738e1e09cc5a8e39ae4a7e12c23a35e0aef"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-213.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "491dcc96b69fdfae3cd38869d16b7c26f4960d0ca48f9e19dffdb44000de852e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-213.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "1c86768b6cdb5b67ebb0147dbb435c6f416513fd899be472a7fa2b39ed1f6b25"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-213.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "ad0f0893a2115dcce03987ee969320c1a52dd785ce725aa466d9012ae96e6572"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-213.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "5164f1865cf572ecc30ea253cf3dd1aebbc134693f1e82b1f3198764d7ac3447"
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
