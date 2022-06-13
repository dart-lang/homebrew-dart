# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.18.0-165.1.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-165.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "b549a7590212025f6a373ec91810f7998a81283b02bdb45325059786e8e2f923"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-165.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "72be84eb899c22ace2b539d53c0387fb99b5a06659a799f1a97231a8ceb4a345"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-165.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "dc57e88d3c60cbd5ee738505fed804d854bfb1b30bdff9f218bb1d1085ec8173"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-165.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "e002f0d479f0469ac4c16138e2c2540b9215751ac6aa14f700d547f49fc98cd8"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-165.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "99c787a521458e6fd3d402bff47f4b4c47c5ad32727f9b3a204310fc25e3b14a"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-165.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "34bd7665d677eb201c3eb78b8e26eb7d3ef05818815005869f0b166c59e1d909"
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
