class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"

  version "2.8.2"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "3419da592880749d1a7a9e186998d8f1abd338f0daa1a2d39daaea7406231c00"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "eea8ad884e57571aeb3aac57aa0e98cd1eaa72fd4ac5408389fe2541c4f990bb"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "0259e4829fc434a3f3b9f9b693ff29e81ecded7e0be8f2831cd0c196b595665f"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "e5dfe9e49d6d03b494ed8fbbde839dc8e9115ab152742299d37bd0bd538bcd35"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "ae8c807e6d6351773686059f5b563f4aacdedfe7bc55a4263df1d14f852d27ff"
    end
  end

  devel do
    version "2.9.0-9.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-9.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "3e2b688214cfb214ebaf1dcf1beb8befcf2af671fdc131aee4a32825151bcba8"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-9.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "a49101dad8e334e4071b8e42179d8bb52e199455b06871ad3003b44eb5c061fb"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-9.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "ccd070b26ba4692847f6204a11bb021b3594cff9d3b5d5496763d681dfee8b07"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-9.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "ea2fb1a511a7483debf00cb44aea035573dff72fd7e131b1d2f9394b425150ea"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-9.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "2326fa043daa688401e0e1d34d6bc6b1cf56cac2fba0aa7dbbc69eda9cd297ea"
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
