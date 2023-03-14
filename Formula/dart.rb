# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.0.0-322.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-322.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "6ea42600c48d809337fbfae95f174432b54add900ff68b629d3a0d1e6729424c"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-322.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "0416c7dc726888041a3cabb9b0a11d674be9f734ed52ca175df9868c01c77f39"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-322.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "667ccd540931217e27d5f1f522a70009b5c7a1f030f7d68de2370779363ae672"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-322.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "bb6e11d2e76ae88b1d543fd830dfb9c7779d50613aab84869ba9068e6dc19b5c"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-322.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "3e29693eeb844bd04a83893a350766fa4f11aa4db2e3287fd2828d3c05613703"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-322.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "917151d52bd340a72e9841dbdbb24313f06961bc25d10170ac2096e435e381f0"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "07136127f4f1fc8ff54ab3d69df53535bed14027d56982c0db4af394ed8d0c25"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.4/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "612118e856e6eedbdbea4c8d9e6cd1fa73a21614db7ed2e66dd991901004a103"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "f8591944512834ba19b4d8383d270d7f56fef03c56ba53d4e35c23db80ea8a33"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "6ee9b912ccb6922e5a9cf1d8687398aa7e2ba283c327e55a42c95c8859892e9e"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "c81303feea24228148bd4ec14c65bb9c341cba3596e3d68e8a874a9df947f928"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "a87833fbfed26ef810cb135c47eb7b5bc24c906b55abb4a2e183fea2d3ce1b51"
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
