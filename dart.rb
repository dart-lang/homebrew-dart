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
    version "2.14.0-125.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-125.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "1bb0a15e3055859b63a20dbb198c4ed1f7adbc72f9b12e533a31c0569a98546d"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-125.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "404a16e48a762b8a8ad650449753a7038965b28258610862b1f5489588c72e0d"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-125.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "a4b4ec6cb247ad5897366ba384e71d1104523820beb351eab3a58d4f46346dba"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-125.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "d59d66ac56e1ba60f1b30cdbd3eae1dd6b242b32118b49bfbb17429acbc44d38"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-125.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "3f99479b81449d7f10c1eb4d09738500270ad1dee58c601c15a7e2077042d0d4"
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
