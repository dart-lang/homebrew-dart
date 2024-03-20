# typed: false
# frozen_string_literal: true

class DartAT332 < Formula
  desc "SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "537146873435b3f0d2a39cea421c958433526cedd3ab81afed7317e91c492446"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "c7d79bfff7f8c929b50e5160af1cc4d5a0ea70f77765027086679cceebe2d839"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "2025a47313408d1b1be943b0ce4ca3d5b629f2a4b2a6cd8ea8c6a323f1693d1e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "16baf24de9e47858152b8a07e2d286ad5298b0d4902c9a8f23318accba8f92cb"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "a26b4f98e7b7fb6feb8abe4864ab5c890434b0a048220e27f1886b7435c1321d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "6a394b1206a73001193befa7aecbfb6bc8c8d154ed4d3018ea9fc9c4c321ea4d"
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
