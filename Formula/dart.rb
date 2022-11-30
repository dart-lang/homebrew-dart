# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.19.0-440.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-440.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "4ce90944144b53b857a0993d8abbc7dcc75a2386a652bfd9cf1a2147d1c17bd1"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-440.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "d625866880692715862e6c9fd2ef41723e7c2fd7257eb916bbe4fa192f00abbf"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-440.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "73617002e26301d08edddd5c31a35f7cc3b27bd39228a5919d531847bc167694"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-440.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "d4c647b7996c35eb15552ece1844ba725359da4b2430d40db18dc79dbfa393ef"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-440.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "a36038d634c464a67b6f901fd6fcac4dc6f71c3897cd3b76f7e30b4750b66cd5"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-440.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "c2469ec4cb65b795d506934c3fce130cd115d02f709f9803ded1ce8b431c9624"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.5/sdk/dartsdk-macos-x64-release.zip"
    sha256 "3993c549cd43ab486624e53287a5e1555f4c47eaabd53af30bcf4772ea48dadc"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.5/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "c677da0c5b1842a5d77414de310acf961cf032c8870c564f2a8b7def4e4d227f"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.5/sdk/dartsdk-linux-x64-release.zip"
      sha256 "f64fbc5b90c6817d6f3a25cf9cec4277343cf265df233600838050639c593889"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.5/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "220aa95150a73931dc5606092291d49a291f30fda4abed121468f01ae54a7f10"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.5/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "f8c6d7e1b0f090c536a64a6a130b065533efd83c290f4510f42325389a0c27a5"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.5/sdk/dartsdk-linux-arm-release.zip"
      sha256 "505df0bfcdb1a22b6486718f6833514926f39f4b28f390b3b67ef8fc7b149255"
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
