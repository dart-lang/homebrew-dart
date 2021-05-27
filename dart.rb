class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"

  version "2.13.1"
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

  head do
    version "2.14.0-152.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-152.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "109dc64142a786c8af63f468f0b31ecb51be512da90e5b34cccf8b1a42d70c98"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-152.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "d73ec37866bb6cac7d24ee18355fc8a28888da44766c496b36d4499396a068f4"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-152.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "e6530b22580448e52c7a6e37a9308d0fe39e6688b7d6f0c3eb81dff82606dd3b"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-152.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "2934d5213b68ff686b488595ee57d3c4236ead3e401769e17285c270157e5750"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-152.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "4cb10b29496ee4a9b05b038ccab13ef3b69941eab317c403678d9deccc6f7117"
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
