# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.13.0-165.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-165.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "4c3f72d5e04ffd1301747bff7de5d5218b1b685ecbcca4bcac67e25fad223bcf"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-165.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "3a58f44c2fb44a3005a8c5bdd7a3a5fef0c4a6dd6219f6515598a76bd8347694"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-165.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "10fc787a92867e5176792d22918ba497ba0adcd9088d84937896285131532819"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-165.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "98f9a60c815a53c714869dd1e33cd91cf512716a54af8ceb763924721d92eb31"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-165.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "e09520c94295b7f2e851df17e2483cc7bb8f16b5b2de31992e836ef79d4be533"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
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
