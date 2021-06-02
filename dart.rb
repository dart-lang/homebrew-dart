# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "Dart SDK"
  homepage "https://dart.dev"

  version "2.13.1"
  head do
    version "2.14.0-166.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-166.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "dc6965d48bb98fe8ce7f10d60c8d4bd3b09375143cf401337e3a0a6641e4cc2c"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-166.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "c3b5ec80ad04b909e7380268194a44404487d54e5076b83751c32fa6cb1c71ee"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-166.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "201a04f2c4e0b48e735189e0e31a1b444f0e0ca84f37a0a81accf91dc366ea80"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-166.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "f849b34106654231d088a87f1fa4dde1f6eb612d2556072bc5bc888edb54d928"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-166.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "4eff3a5b7ff8a1ffb1c54659aff74f56421fcc189c23710a2faba7d9c28f8f2d"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "caff3814a7653b5c733a13392215469cbf357d756778ff36d4a0955bb3c8664d"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "384b936b2033f9d57b94b2fae86202ba362bc5df811b5d98e401f0ec9fe5087f"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "72d2e31ae61373ad2596dbbf5a2a201ae27268b410fafba3510844b13bc2647f"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "ec652347a2fc50fdb6a49576eddf5689c7e647b82be258ab44c0dcf26a93692d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "2270c67049df393cb9a43ad15d37fd0df7d7e80540233b3f922ce4f0cde30d33"
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
