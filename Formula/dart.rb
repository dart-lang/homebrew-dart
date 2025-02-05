# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.8.0-66.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-66.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "14e1a05cfd646f9c0abc7fafd3856ad2e0125783c2242791cee412d66a81bb56"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-66.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "eb458e0498c3a5a296830205f994dd120e98accc3a99627a42e2dd3cb8827153"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-66.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "36b40ab2315664ce1ffbabf96c192ef726fad3309f82f1ca9cef9bd389ab082e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-66.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "92553f84c7e7df5d46b8c8f3f7a22de9c01582a35047702df555f9a0499b65f4"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-66.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "e442810fce63f5799262da19275bc44efeeeaf2f4591a2d3e8d6bebc353cc627"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-66.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "09510c713627950ec916100489931ed22745c7b11a7ace27bb247f2eec98f70e"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "8ac74b6f5e0524d767decbb7a04e93482be4a09d012cd577f29113893c19bed8"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "453bbfa3d73f28e090b644268e2c809b899d11a3a6507874715e1a4042166295"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "5a2953ec76c8139cd73d0c0b482de26d0b86a5a7e37579167bbd33493063408d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "eeb3cd33ba4d8be2cb5e43c3283a5034f009103cd641eef6f0e3cad701477c43"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "f475db0944922d9925b4a4266c31f8fafd39b01a3cc130422e785c8276eb13e5"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "fb06585de5d9b2aacbf8970be69c91292b29b4dab315b84789f0fe528675ae16"
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
