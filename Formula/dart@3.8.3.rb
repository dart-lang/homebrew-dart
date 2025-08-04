# typed: false
# frozen_string_literal: true

class DartAT383 < Formula
  desc "SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "4ac0ea9c9e68c1ecdd1a0df9202a48b5e0a76105e0e8551fdfc60daa4d4b0174"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "74bd98cd8c4aaa049bb616886a18237b66663e045c3934a01d7ca04816c0733b"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.3/sdk/dartsdk-linux-x64-release.zip"
    sha256 "008cefb88505760ae514062d576255305c2bcba40b0f9b7c70fd524d786d122d"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "2396d820adbd3bd15f334cdb1aefbbc32f473d1fdf06315af122dcd7c7269671"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "61ef78b034bc9b8f2b1a27166c30eccac2b1b5c7c491fdfaf50d9137d89328d7"
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
