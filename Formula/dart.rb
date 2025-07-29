# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.10.0-37.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-37.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "4ffe3fc728abe6ef0acf32fd74cf0f316b216cc0ac42960b8ae11e35113b1128"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-37.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "59df45f945ce5a62b89389dd2d614e2493a066604084e1d4262f138596668ee1"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-37.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "2cf4e1fe6f5b46873d795e82b235f4b5b8a16b62e9fce4897efd87d210efca7a"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-37.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "7ed748630ccc67e4fa7e3a271d96dd6b80f216cabc9b09cd2c93318cf6f42291"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-37.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "697f291059dfa57037a71082c136ff51ad451888c983ab72256b3a0d34dbd5f0"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "df47f9b0e344ce55dc7fc36b34f3cad2f51872550b8487e3dc7f90f6d951b891"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "3cefd840420a352977d364fd2eafb8a5f3a8515ae4263159f5b1044d6ba35291"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.2/sdk/dartsdk-linux-x64-release.zip"
    sha256 "2945baab11cf7472328e5573713993baf917957fad691c1461cabd5a096e8311"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "6057db4cd909e37ec5f7dcf34ac0a65bc34fb41330b4c3718c43db1a50e8906f"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "250c7e7f77456213c6bdd90c731dfac77c3406a9832f3d2ba1719500f1af239e"
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
