class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"

  version "2.13.0"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "11a1153647c8e98a4783eb29e341636ef8835fd3b81fa05752e00e448ba37785"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "4d39fe12ef1fc2f1c98246c1f8482203398eb120f724c0789db8d4b2ffe25362"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "b510bf547fae66ac2e5b345aeba5f669c67ec99e5d46e0341d264fa748e4f6f9"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "011dee9959b6ab3dd3fb7d2db78d107e51c0b8f3576d32606b5da0970bb2e391"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "daa1ff3a7efd6fed38cbf47bd26406858ba189562261e6840e2ae5683abd12b3"
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
