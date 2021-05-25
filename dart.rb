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
    version "2.14.0-145.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-145.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "f4c8ab7fc59fcb682c992277e68da16f2ad842439c0bd1d271cf548bfb8b8cd7"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-145.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "ab53802b73db128d8b2cb9a2319ce6b8e80221b0a7c44c64fd36854936205c5c"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-145.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "ac06d4220ff1f083b70281f35dcc3151f4ead96fbb5ba6f030b0e5fbcc8e0c82"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-145.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "e16566e319ec4cff8fc117db0ae1b6221ecc9e13c0ff40b87f88f129903505aa"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-145.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "c094bf03bea7e0703bb5e7d4b5ad90ce12b0cc0916fff74dcd70ae448738e053"
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
