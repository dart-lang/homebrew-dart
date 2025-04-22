# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.9.0-27.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-27.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "485858bae414a440500beb6b3747fa64d5a55a6b3be19730a1127ae0374328f3"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-27.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "c48709d3bf3c25f57310675e9b5f1571d4ba41914b9e9487018d2b9d92276e04"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-27.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "3a11675000bc6fb221c31794775725c7f75a5a388a7e6b7ab6400ca94beb9c25"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-27.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "cf43122b04851e76b94ff6338404480d53b2ba0a242e610b12172b9b53284b03"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-27.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "537712f14bdbb38dee03c7d8874c1b2630a96691c8845bd75af4dae004a404ed"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-27.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "4caca57f138bae0c141c9a0333d437aa04a887ebfd057cf9abaaf25f1bd5e9f4"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "98a83e7f279f13c0589403cc11cbd4b75b9fbad89ddb5c2bae7a259b63bbe809"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "eb6479d1880185b351d7fc1382a460417b140a9dd6437a67a969ef69d3fa648c"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "b772a2807d2fcf08b4edcff998123b0e87391c12067ad0cf11f7c50ca31982b2"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "8231834c3da17d281d0ff96d46ebc237cdb2fc7858f1b3091c488376724141b5"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "16546f4cd27fca883eee7f1e7597f409a67e0254174443aff6f62c35c9ff78ad"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "c518909142c6c3110ff8818445d2359103deb20d9136188c8ca3529403b84a4d"
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
