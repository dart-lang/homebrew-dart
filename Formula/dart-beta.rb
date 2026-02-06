# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.12.0-113.1.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-113.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "585dfa06be85fd38de084cfeb698f8d6e204c237d22174102ba019ff0cbeb758"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-113.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "9391f9350e36dfae36b48146bd85f5ecbcd1832f36a413be32f09f49ab763853"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-113.1.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "1af09b9c663079f5bdd76388d375e3051cfcadab625cd8705fde5970eb0b73e6"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-113.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "13926be703ee660f53eacafecc3d46034aed73bc65a2d0265e2e7b67f41364b7"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-113.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "514a2c3363b8cef13206d98f191eefadafa3876d06c625221071b1a3f3b98157"
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
