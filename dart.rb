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
    version "2.11.0-218.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-218.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "2eb6dd522deb1161170d77546dc2cc91b9e78875a5fbf2b8baf313643d6601a5"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-218.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "57ad9bcbe5b65d9c30247d07b61ce139196852a56f9a7a634adab9004c6b7014"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-218.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "c5e5bd75667e1f34e3c29d90e8c6d245e1ab6189b46b11083bd10ffa173c6c06"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-218.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "71ddcab5b9646eb19a392a5eb1cb34a04a3e0d59ebaa09b6623b8c98f25261a0"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-218.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "16683650cb133c8ffbe5cff3d56c342203851cfd4b96fd02c2e8bb81181c0b49"
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
