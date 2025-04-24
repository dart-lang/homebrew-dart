# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.9.0-43.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-43.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "8ef085c9262247a2a5e26edc34e6854dacb943e63f601d4cdd4d165a628b549e"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-43.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "404f614a40fef334b40149b60c218bd90d33bd059629ff9c90fa12cc6d4563bb"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-43.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "22a231f7fe3c0897ccbd327d9613a274e302cc89098b4f55131cc422957ae12f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-43.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "409cac8970bc7831a6e4b6582aa32ce5419c9248e9461a63f6451630f3bb8855"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-43.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "969da5e070908a169a9f59a9a003474c6d1fc3d4db66039974149dec3b8bad68"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-43.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "d6bc5b40c3befce88a9d24059f2a31d9d3cfde1ed068a561ebff398ddec816a0"
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
