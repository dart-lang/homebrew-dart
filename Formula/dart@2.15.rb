# typed: false
# frozen_string_literal: true

class DartAT215 < Formula
  desc "Dart SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.15.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "b3a6e4c21da6e4a751aff5b1597c08b4ef58683a69fc7237c639d2d941e637e2"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.15.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "0f45dcaa53b4090b69b277b885ea9a4cb3a41589c9119113e1b978ad55ce335f"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.15.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "491ab94edc52f9bc02a95c5ad14d99867f09d56b66e0e9eafb7b904bef79d6cc"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.15.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "8836c294234352cc53e8aea4a1ce0442ebbb769a536ce7f309579da5020a2395"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.15.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "751935fc08dec2121410c3f2f33de8215d8a4e5f21192a4c42c4b81dd00f8659"
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
