# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.1.0-145.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-145.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "706d820f62de442da29829f7134d2844a7b5d70b186c4d30820ec76fcf465d46"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-145.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "16cee0e1f006a21480d435173bfd752161a6d6fabbd5ccb5c120bab4d06157a4"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-145.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "34eb578a135444afdc2697340effb1dbcfa8ae205cf03ca5f84f3db9f816cabf"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-145.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "565c7ff20ba87d23bcf657d487a8e9feae1ccd8a8cf9a43019aa734d69ab17c3"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-145.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "aeaca7548b473605537cc5ae589e45b0106ec0c257fe304326f3b759f0a14539"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-145.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "e01bcb21ce53183729c48f488115b33f44b0126b003d2f72a253abaa2f3ea6aa"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "2acde2ba8619253140005b5753154c700bf2dcf71ef1a6a8d80f3ceb339d9bb3"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "2f74ffe39b80f0279dad79b51edc2136970b0b71ad3b01b9910aab7c8fe748b4"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "0ed1bd52359b583336c2a3a85fb59661d557c2ec84c51360e23f9b98a61f50ff"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "2f62a112840dad61496ee24931e1872885690b89fda3f90d713cd9240afc787b"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "99ebbb0f2a2f6fe0d0c2df839ca750558949d7cc88ea3315c70ff95e11fa42a9"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "18ee02a7ff1117a82328410cc6f1af4e3525cddc4cf675858d499916fa3bf28e"
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
