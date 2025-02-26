# typed: false
# frozen_string_literal: true

class DartAT371 < Formula
  desc "SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "a2765917b6ae49d1ac119553df9584989f9c441a46e8f18c129ba52489658d2e"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "f57c25163092bac818f8ca6250a0d8b2c56344c6a075a1bd7c60da7ac28b32a4"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "2813959e7d9650334015b927cc533f5beadfbf7fa48248beec471f8942a0ee71"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "bda0bc4f7ab93ac810aeed47a5f857e36df772ef7ba74108bd2a6c7bb10446fe"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "ea91ddbf7d0278b377e3c47175ce4f5da726e9a81d49b987f13eadcf969847fe"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "199ed39b5f5c90bd26f3d1560959a2a81786be752f779abc7e3f933fc149c890"
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
