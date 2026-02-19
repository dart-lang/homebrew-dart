# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.12.0-154.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-154.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "fef8caa4e3b90bc13225918095c196c346e656ecb8285f0e68eef912c4f196dc"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-154.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "7293d0ed2ff977ae31bb19d0892c6a2af5025d19b7120d514a2f43eee76fd407"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-154.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "3c6b258ba43bd53f759d3cbd596159372dd9e42416f1cb3769b4debaff29d304"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-154.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "b34a26cfccbb8b8bad4f086890ef7a1ed6a42319e6a51195d34195f1b7443555"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-154.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "52b9baffada5443c104b1fe975fa1bab9e518ceca75423bb945c87696f7eab31"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "5a5c29c7a8381269332801326b11ccadcf0cfe7301ed01a3f06e81766bcb8d74"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "223245a42eab1b811e502e15625b867075ffe012de9eb5374a4cdde2ee087534"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.0/sdk/dartsdk-linux-x64-release.zip"
    sha256 "f31729b567be318c7cc23bdafe6b9a997fa7ddbf829df5016f066227b6aa0c99"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "76bfef5c809c082177df6c51bbf4800d8d4d755f2e96fb75162bf8d2b032ef83"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "544e6137a072d73451148db128bfeb7fb73992615537b81d641b3396983c6884"
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
