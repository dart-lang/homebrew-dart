# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.9.0-95.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-95.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "7ff3ad665aa21d49ea05c4745a6ec026e9aa0dc0b5869ea88d587bec21635dbf"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-95.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "23acd18a0ef17deeb7c9cb655b1f02b061471e260f276627091440ecad37e2e0"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-95.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "11ed7288b8311227595ea027ca6e6a3f23cf53c25f18990eaf9638e476b67e0a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-95.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "7bef1eaef6764654e049b091e2ec56a1646471d2a1354c99e42e40fe75acb097"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-95.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "d1e4a5a7d64630471db9033fdfd7766dc8b1f1903f9d8bd2c83eb90ec367ea47"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-95.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "f0704726e5c02c5f7b5f7cfc9a8053fecb2ff8e96edf5819751c150f9499c192"
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
