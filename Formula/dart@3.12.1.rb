# typed: false
# frozen_string_literal: true

class DartAT3121 < Formula
  desc "SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.12.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "c56b322cdbc15e0d7c373970c2e2be53bfb438458bd67c1828703e744acb7916"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.12.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "eaff3823d5a0c5cdcb65b38adf204e5f35290fcd560d48cb47c2fac7e1547b97"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.12.1/sdk/dartsdk-linux-x64-release.zip"
    sha256 "6a2bbf64a133c9c86a62a532dbd3e0b4db4ac365abd456e9f9d1c5df61fcdbf8"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.12.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "b44087930108f6d7f56bf580a02d5d2a97ff94519c5a288339982202e1b4c481"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.12.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "51dfead169350b452a24230b9bcbbf11ac15cda3f993dab32c63a51b3689bbb5"
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
