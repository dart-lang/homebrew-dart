# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.10.0-115.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-115.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "8b7f27684cd6ba8a04f543152238e8447494661204b7104744e9a24e4921ed0b"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-115.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "d7a5acdf2a736c0654364291976f72de911dd6e0239b95f33fecf038ea145e09"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-115.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "d57cf19fc551dacae1f4d240e1b930ed569181a09d9f8c70cd447f168ff1b22c"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-115.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "9b9f98b97c7de6804021dc69056d9c561ab28bed8707b8dc39f08e3053aff96f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-115.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "156ce693865eef4fe7444c6928f38d36605f55b9c80ab0c3818e791a84c505de"
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
