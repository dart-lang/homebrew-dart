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
    version "2.8.0-dev.7.0"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.7.0/sdk/dartsdk-macos-x64-release.zip"
      sha256 "4d4471543589e0027ec5fbe396ee362971ada24aabd27871bf328ea09aaee736"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.7.0/sdk/dartsdk-linux-x64-release.zip"
        sha256 "ec2dddace38bbcdd38c48fa09c333be0eca9e92b753e458ed79e68a9b931be8e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.7.0/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "8f85eefaa571b57e024ac1065fa8c132be329bbb9fec9ea5a7ccf2adb4c16648"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.7.0/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "34625e8cd387ccbdab70fc9ba24b37b071c0b07edb01e5d1926441004d79e5ad"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.7.0/sdk/dartsdk-linux-arm-release.zip"
        sha256 "588286fbdbf3201cc1909e051c75e7459dee51b45a9b8007ab4cf2fc7faf9465"
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
