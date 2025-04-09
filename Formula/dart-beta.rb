# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.8.0-278.1.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-278.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "8adbfc7c621be2c8c69b7fd22ae44662bdc6968f6b16eee5cbfa7bf9ec60d544"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-278.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "59ba543c489aef4cfcee502194f67ded78cceb2da145cae20774eb5b5fcdd7da"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-278.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "c2d0e8f50f0b2634cc2d1ba18c0341199f0d879d8fa489536887ddea77812cef"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-278.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "40e28458929211fd43e712a237fdecc6be7ba2fc6493d26c842f586734a909be"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-278.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "130cce8ba744a6d37fca8fe0f06f68cd3abc119f250386f41424d2ac333c2269"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-278.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "eb85834ef45179d946541470ba171a50f222435e6e96a149e3c2b403a6b7386d"
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
