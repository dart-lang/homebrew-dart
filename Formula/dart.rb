# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.0.0-305.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-305.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "e838e1cc127ae93c39cd5ec7bbaa7841695b7fb07ede48ac64e95b93e7c84f1d"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-305.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "cab6ceadcfe7b8f365829ae4fea710150ef9f421b5a30e8159287a8a1d2174a0"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-305.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "eb1c63c0de6ffcff76d81973346697007a62815aa2db326d23e0834535da0ec0"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-305.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "ea68ef33dd8e0a956a4564ab055a0548d4a932e0b77be7d78473bb4792f0673f"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-305.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "24ee8f580d8b13d8e86ce77a5b7d1ca19061c1a95829889253f9706e7dc71592"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-305.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "5c38f3036a070f11f560743d3ebeb8e811697837df4c112040a85bfa672510c1"
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
