# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.5.0-14.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-14.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "4d066c4c6d8fdea724b24276bdac8f46fa47afd74556bec86d485083dcd1669d"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-14.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "474ea2031b250f2cf818a6502ccc6f3c8d5275c462987a92b224049e8bd08aa7"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-14.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "a52988e93d3e3df72c041ebd56386ce106e6416809b4fa3bcaecaf228188d787"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-14.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "4ed64e8d1f2a7bfe489025f854235ae646f22b637f5b5654f5848817afec0577"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-14.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "70d1a5a555d4ba349aaa678f8ae626cb7eaaea9dc4310c04c49764c720731004"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-14.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "137481c3dbf468c2e71b6f2f6789098e8f3f8b92c1391f850598c6f28edc944f"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "33fe912cdfb48231424aef4a8847ac1c0fcdc76d28e8dcdc68504bd05980b42a"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "d84b2d0201976871f06ac63e516333c82d7c896abe14c0ec8785fe6dbf68b267"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "ac7a96f730a632a0960861a6c0bdced033d8c324f6054e6f7dcdea617d77efbd"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "92069b915a365fe414d7ad98958e7bd752a47d1ba709be940590d59335a802dd"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "f3da7690e8b238e77fbf2535a0c3336c3ccfb226e431c926f58334910f7ba595"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "4e0759057c75c1cc3f3036ef4e09fa408742bbb562e6aeebef9c05a848d61d26"
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
