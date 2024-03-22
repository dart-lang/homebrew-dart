# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.4.0-190.2.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-190.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "e4a760bf81c0480e7088df4a360a582a13f0769d1072d4cee85c05fec3595aa2"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-190.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "718d15c71653d5ec9e19cf89311e72c2a440fcaa99b3e9993603895f38b6dcbc"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-190.2.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "3397ed6f51e517d9d808c1466fae48b46647cbe63d13248e8e503dd7f591c7b2"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-190.2.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "d43c7ba125f2b56e13af5e9fb8e552174de46543d99466cef4de143e24876b65"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-190.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "b6a9dbec278a005413845dd9e7f67ff660f496f969f8e8cec13a2e0511417afc"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-190.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "b2cf0c4ca05c26aa98a91804c9e9f85f547001d2645ff9bcfe3a05a06e510441"
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
