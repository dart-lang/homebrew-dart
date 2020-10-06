class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"

  version "2.10.1"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "f2dc5d040e908183b3797c68e03cadf7fc1f4f23092651b2b39f7bdb38e4c37c"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "3795860f2d27b0aebad25e5a9191c2534ecbe613133572f565201d50072da4db"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "bb7b7743d89b2c518147d67f16dda135bebf02f289acefd27c3e97ad0e828a27"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "6b4e8a05283cc88f0607eb0e89f21494a5e5ee42d598860119e52b8ef5a207cd"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "f341167b34fdfd55751601e7ebc2dd1e9db3aa8a74bf765d6090f92878cd1ef7"
    end
  end

  head do
    version "2.11.0-189.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-189.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "57c8bbdfcbb39a1ff16f7c252e8536160548a7981b178cd3e75e7cf9c8e2bca0"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-189.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "21846f277bdde3db6baeefb63b5c137cc6f7a152e33d88406e20c5a0247d3086"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-189.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "ec162e386182753736d535994b09783129547966330fff6bf2df14e67e7743c7"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-189.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "6cc4fa88e9b0160016972986622b56fd4ca934fd5c4d330fceef7c5dc2933b99"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-189.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "e8c1adc55bd0e8633e92e1cf2bc0bff6b1e03ae877ee1e43701f47bd7f170f47"
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
