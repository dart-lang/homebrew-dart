# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.13.0-215.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-215.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "8d52185649db0482f223e6794ed8c770fc5d1e0a05424955f5074c64c1f5dea1"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-215.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "99a399b783e0d7a92e2c934842ec27230a9e10b781f4fff7a24d922729cb2d26"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-215.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "4e45680efce608f8568156de292aa45b4d0416a89078b49b5fb0567dcebffc04"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-215.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "08340a5bdb40bf0381d517c3a721968019c3e21e6677d0fd8f205c064977515a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-215.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "355703ff14e7d92e0438686dfc6a14c45648488e46745205480aa32d4ef22b23"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.12.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "38199f56fe22f2235e76799191d5b9516e360369c61b6ba4411398d5d5920bab"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.12.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "cd8753928e77b6b665bd70dce0e64b4ec6d2e2fde141d6409bb716c8ac1f1c0a"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.12.2/sdk/dartsdk-linux-x64-release.zip"
    sha256 "28e47b44cf075f36771046c068bb0d174201cf9c7608744aed1cc23204299c2d"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.12.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "f82c83ece7d168047550dfd4a664e4071ac7c488bddb72dc43102c22d7e0b518"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.12.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "659fd41329db2c17e5f186c351fff50ac026b0ed1770a6ace712364d309b4a39"
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
