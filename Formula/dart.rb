# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.9.0-23.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-23.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "38166eb01af4af952b3a93fcfaf0f78ac1e5b8eafe45ff8682d5ae7a571ef355"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-23.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "7260181d4b7bfc8eecd782d6b39c7ba262cdbfa941e1d784df01f3fea22aca0e"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-23.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "e40de2216df85fbf17f98ab53a040691c6a9d66bdd1d948f30ab63cad9c256c8"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-23.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "629c37e7c4b2cb0fa3f1c255820ca66e191bf7405110ddbb583c1b84a14ee358"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-23.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "926d5bce4f3e17ea600871efe96b36227b4aa1325131ddcb530454c8ffabfc4e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-23.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "fd7d6e4e0adc5b7e48bb4f1d31ce95208480b47d93faf72215fbd76851152cf1"
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
