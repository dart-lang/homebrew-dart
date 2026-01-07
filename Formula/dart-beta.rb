# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.11.0-296.1.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-296.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "f7847923066ea9f3dfb43982bb61803cf8592b1ff77d0ede5c44ec82e10b479a"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-296.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "eb9efd944f7f2824177ce007aefd08bcb4d5f73ca9f81a3699c063838be83ded"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-296.1.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "163831e359ee9aae24d17d3570935d5be37becc2d6f45e4943931ae6d9f0ac21"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-296.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "cdf24a4342bd9b139dca341f83d43cdc5bcb536cc8858e1bc25cdc481c5435cc"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-296.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "5fdb41493e4ed1d0157a227b5438d691b4ff29e2b5c214b397f895ccaa7c1d1e"
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
