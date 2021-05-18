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
    version "2.14.0-115.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-115.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "3e4f3c497418dde02ecfc625d39ae93fb42d46869333be6dad98ada60de665d7"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-115.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "7533296ebc05bbf131a94602251410cfe8278e11bcca96835ebdd8b4edf3aa2a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-115.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "ba9a43eb99aa22e85e5356e26b44e08cdd751f1c29965c073963d17408df2ea1"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-115.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "628bd3b9ae6ad3b01c850d23fe90e51962574f2be05e96a9c37af35d61db264e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-115.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "e77473e8a28cb4d8f653ca783819db2748ee8c0b0eb799b7bdccf5359b6c689e"
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
