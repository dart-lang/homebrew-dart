# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.10.0-134.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-134.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "d756b400585ac2cc541dea1b8b78eb3ebd59227c43a8c98f86134fbc89887e26"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-134.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "7e6a661b3727d8da1c6fb753b72f5b7f0d59af98f686207c15ab471e8fb8fa6a"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-134.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "c861683c39222199096cb7774fb87091ffdf61652353d0b1f106b9b85e1cd924"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-134.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "09a34dbc5e3bc40f4b05d07f3e0aa10bf30371629223f76e669a62a9ba045c88"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-134.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "f0578bf4aee7171d3bff04dcd238dbe9a26881707166464a2bbcf0ab8b9508b1"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "5c0a5b734f24e8a9d09415948100a24ea9a64753f69019c519bf576cefe5dba4"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "b229825c5ffc9b05e6c05f0833d2dd27557f5e7ee428b126cf2965e4f31d4d03"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.1/sdk/dartsdk-linux-x64-release.zip"
    sha256 "9e73c2dbf557b844328ada4f0b42a38f585b8226e77e3e96456267fc68ae2769"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "d8ec9c7f0ae8f242ea9c76b9846aaeffd484c656879befd8e8ee7fc1e8d167db"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "1cf6cd418109de72da92ed60e133bebcf5535adb2220ba7928d79d1d0c2a453d"
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
