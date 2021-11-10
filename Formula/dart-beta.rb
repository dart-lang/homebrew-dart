# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.15.0-268.8.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.15.0-268.8.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "fe61895dac764fcfd9d004c6a466d1db22d341d212534e753970b41a73b02705"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.15.0-268.8.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "cfeda87ff6b40b6661c58b28ed5330001105426c580b04b5586a2947cbab7af7"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.15.0-268.8.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "91105c1ebc6bdf5c2b3f42cb8e22a51b80343d3a256117b6b1539a01232ecefc"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.15.0-268.8.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "806c2da47d1742e53239bb23a9527805c2feaaf7e263080f829fa0a18d59b259"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.15.0-268.8.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "c5396e6b36f38339cb36e34481e1e49de6de1f49fcecd82e370787d08659671e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.15.0-268.8.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "60610240a6d1bab7389a71d84a40d6b40198d11784e4c49ee224ee611de1eebb"
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
