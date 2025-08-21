# typed: false
# frozen_string_literal: true

class DartAT391 < Formula
  desc "SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
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
