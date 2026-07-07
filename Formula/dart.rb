# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.13.0-272.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-272.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "3d775420e8053d3bd2d83100916f3c155a96557ac65c8815911a08de70e681c4"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-272.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "a8feb8e0e5559220b4b1c702b01ca48c15907d49d63a25e783bd19c1d9faa5f6"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-272.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "92753344e189e409aa8e0ef99a924e9ee82330f7a41f56866dc034ba194a27d5"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-272.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "5a5a291f42b0818c37418c628830a021857e49183b8ba1897ef4163c97cfde2c"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-272.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "8ef080a14e023da4d96834c32cd7a743215e3fdadd208a57597f4141505d6897"
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
