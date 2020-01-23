class Dart < Formula
  desc "The Dart SDK"
  homepage "https://www.dartlang.org/"

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
    version "2.8.0-dev.5.0"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.5.0/sdk/dartsdk-macos-x64-release.zip"
      sha256 "9fb84dc5732a9701bbb2ecacb32274c1392ea334cb75ffd0c1239c1541fc84ef"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.5.0/sdk/dartsdk-linux-x64-release.zip"
        sha256 "c46f9b5ca87ac9c242c299ad2f9e6dac2146b0978f35d15882b645d2d87d5037"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.5.0/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "488e4e39065d49b97f6202b9cdce9bf76f6c419eaef82a0845e5647dd8599a67"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.5.0/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "2d6a524da66a75da42d8719ba4e5176e2e9982947e13961a7d6bd58d899bd38c"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.5.0/sdk/dartsdk-linux-arm-release.zip"
        sha256 "1ee123b08fa422d22b9145ea03465c96a040f8efc5c7d79f11dd6dabe63fc8c5"
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

  def caveats; <<~EOS
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
