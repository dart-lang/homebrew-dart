class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.10.0-7.1.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.10.0-7.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "ae7340108719fcec383c3728c19dee2de14cda2744215ab23a8f4f32db26e116"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.10.0-7.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "736dbbfc7902389c90bc8395fa83f792b7e2a021873993bbf2013cf22396d050"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.10.0-7.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "4f1542ac667c046fdc235550a515be94f64dc3a138f3d4bb997b393206ef7afb"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.10.0-7.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "44a71a80aadb56c759c5541dc48181762cafc88564337c5418fdded56e7b5e7c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.10.0-7.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "ed2b083d55715436787eddbfaefb4ce0f854ddb194a60dab05674121735dfcea"
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
