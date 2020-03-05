class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  version "2.7.1"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.7.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "4eb7f0fd651bcafe3cf0df8530eea5891ff7aebb5d88f83cf104d808e5983a0b"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.7.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "ea88fbcfee9fc5202b89b8fc4102442edf3946a25be2f7e7f7ba85d73b4c4dfe"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.7.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "216ad4e78685dbd677ff663e8952eb3f7dc804df402d48bfaa507db864c8ef31"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.7.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "d0fd0289eabb7ab0c44e853605c92cf63dcaee9efeda60f252f020ff07a39854"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.7.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "a8d5542f49602958c099d26364249b9a8a94f50b2ad17645b25617fe17e4793e"
    end
  end

  devel do
    version "2.8.0-dev.12.0"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.12.0/sdk/dartsdk-macos-x64-release.zip"
      sha256 "7e2c117aea1487d0ba55ad73930e965b309d31214fc01e39d4f2dcb6ab553ebb"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.12.0/sdk/dartsdk-linux-x64-release.zip"
        sha256 "4a339b20c9524c940dbb06f0ecdd408f0a0cdb91568d0d82023ab4f21baf21c7"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.12.0/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "1109c0bc0570216785168fbfa69fe5f7b79f056069fa739f8ea3951800c60499"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.12.0/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "5ff10ca90239c90a5acd4419d2ccc8e3aae76a9f4750723ebd4e4525d57179e1"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.12.0/sdk/dartsdk-linux-arm-release.zip"
        sha256 "dc9e0282c721168c3b0789d5a6d262e2fc8a866810a2bb26bdc10e462df1f6bf"
      end
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"]
  end

  def shim_script(target)
    <<~EOS
      #!/usr/bin/env bash
      exec "#{prefix}/#{target}" "$@"
    EOS
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
