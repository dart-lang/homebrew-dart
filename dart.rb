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
    version "2.8.0-dev.14.0"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.14.0/sdk/dartsdk-macos-x64-release.zip"
      sha256 "1a73c5f352f89313cfe84fd0b1058c840927332fc6226fac4670a9a71db65a63"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.14.0/sdk/dartsdk-linux-x64-release.zip"
        sha256 "6fc9bd33485e18e7ad159c31286ab4a54048babd065866355e5e77e366cccd92"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.14.0/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "b9501f716d74909b435dbc9e350455f6d58076f016270f1ace28d87c621b00c4"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.14.0/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "a11666bf03b9b929f357d41181a8174f24a42cf37c948281d3bad0eb6e9e239b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.14.0/sdk/dartsdk-linux-arm-release.zip"
        sha256 "f1fbc5614f444342cf3163a90d8a82472865d542534f095c4aebb8b7a67ae84b"
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
