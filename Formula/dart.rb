# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.14.0-134.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-134.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "bd2df2060edeb10c5b6edd76382d10a6466863793ab12f47f2b90fafb41d94ec"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-134.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "c5cfe25c474052c6c2622182ecc5be0c7401556c44fa8dee9dcd83189aac215b"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-134.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "294d8eb5610e903703599f3160c70da94d2b04c5844400a70c8c6427ddf3e463"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-134.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "a139f14fbee00db9e276fb25ed3f0c2bbdb78e5ce6f7843cb0e513bcddf8408a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-134.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "f33fe56c1e15f85b121d110994fbd8b0896da69be6d35ab218dca1e9380fa114"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "6f75f0d6bc10c00457fb5b8861b26eadc5d883cfd11aa26a8c4f6353af370f47"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "1812d602aed0a9cf7281c93f514a1e1aecf60dc345c4337dba4ff28fa8d398ca"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.0/sdk/dartsdk-linux-x64-release.zip"
    sha256 "87902573facd8acacac7ee1fe73fa8d0668e06065016068e2ed6c5c99c6b1ee0"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "20141a0653327939bb20c4b87b231226beba1128d8a9aedbb30cb5af1a2790d4"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "d75787da6fcba9362ddcf0643443b04962e280ab09dc48b05ab49e6538e013ee"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"].select { |f| File.executable?(f) }
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
