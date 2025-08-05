# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.10.0-49.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-49.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "2ae03d2015c73bd3e1e476fc5a2c1a339928caee57f111be08111b8114f3c202"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-49.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "c433964b3aee5bf8b001cd4fec3c1b164ab7b9caafbf929d665b4999a977311f"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-49.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "aa6840cab212fdfb6515a5c152fe9e627b6e2832ccc7a715fea796b70dabf4b2"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-49.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "1014dc9a3a36f7bfeab397218932571c8a82e4a935a21368a403882909ca4460"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-49.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "64a77d7f1cfadfc4082e8908e409a6e470bcb92a3a04a23655f5cd75d6e13e20"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "4ac0ea9c9e68c1ecdd1a0df9202a48b5e0a76105e0e8551fdfc60daa4d4b0174"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "74bd98cd8c4aaa049bb616886a18237b66663e045c3934a01d7ca04816c0733b"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.3/sdk/dartsdk-linux-x64-release.zip"
    sha256 "008cefb88505760ae514062d576255305c2bcba40b0f9b7c70fd524d786d122d"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "2396d820adbd3bd15f334cdb1aefbbc32f473d1fdf06315af122dcd7c7269671"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "61ef78b034bc9b8f2b1a27166c30eccac2b1b5c7c491fdfaf50d9137d89328d7"
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
