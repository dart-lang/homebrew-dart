# typed: false
# frozen_string_literal: true

class DartAT333 < Formula
  desc "SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "33fe912cdfb48231424aef4a8847ac1c0fcdc76d28e8dcdc68504bd05980b42a"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "d84b2d0201976871f06ac63e516333c82d7c896abe14c0ec8785fe6dbf68b267"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "ac7a96f730a632a0960861a6c0bdced033d8c324f6054e6f7dcdea617d77efbd"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "92069b915a365fe414d7ad98958e7bd752a47d1ba709be940590d59335a802dd"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "f3da7690e8b238e77fbf2535a0c3336c3ccfb226e431c926f58334910f7ba595"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "4e0759057c75c1cc3f3036ef4e09fa408742bbb562e6aeebef9c05a848d61d26"
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
