# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.15.0-34.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-34.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "00cb670c74130764da58f8ea8bcd23d4130e06bc53d4f0265116eb43525c0507"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-34.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "6ad1f8124d4c5c8bcdaad055badc1616feb8ad0198152d6d2a4ab8356a629279"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-34.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "67d401017f763efbb1f4bc25df0477aa7a54e32ee8cb00f18c6e7d920e83dd73"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-34.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "fe5a694bf8960e0b4bab65db1a37e45ee26c49db65f98fa8c0eecf1edcf1b021"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-34.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "685bd57aeb43679ff840b2bc1e733da90e999a9184cc66f4680750fdf3b6eb39"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.5/sdk/dartsdk-macos-x64-release.zip"
    sha256 "15aaffcc5c6aebcf5e907f721671a9f03cdc5e0b95affa59a9d8291fb2972421"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.5/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "9dfe7d6f2558816c2a978aff6c80e8a4509c6cb726c0702a616c64d286f60e88"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.5/sdk/dartsdk-linux-x64-release.zip"
    sha256 "ea864bc64df30a6b8bdf30b2e32550f7717d9a890de8f40293aeabb924fe232b"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.5/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "19a731647c3ed55058ee46dde00330150e6a8729bb6121b4a31e86084c8a3e6d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.5/sdk/dartsdk-linux-arm-release.zip"
      sha256 "2c33146273ebc79e46bc06c9d46eaf1c9e36e25a361bd919259b89d231889f91"
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
