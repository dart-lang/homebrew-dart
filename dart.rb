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
    version "2.8.0-dev.15.0"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.15.0/sdk/dartsdk-macos-x64-release.zip"
      sha256 "23a4f06cd94ba7e87019457167fc4236011bd4d7d82b5482b0ecf1c79e79d48c"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.15.0/sdk/dartsdk-linux-x64-release.zip"
        sha256 "84aa9f32d34cacd83301983ae25a6d0f75d6567837e83e47fc6b96b30c34354a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.15.0/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "6a3ef80f220500ca93c87110e2f4fe8d8a8b533010def527a14f16d3bf4d1dba"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.15.0/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "77e612f750466f227892b00d07a6a7c8442c096d771d349dc9426530422bc960"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.15.0/sdk/dartsdk-linux-arm-release.zip"
        sha256 "b0558cbe69171fb25e9524b3078b5fc7338e002435a6233e3b9058c6c5534499"
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
