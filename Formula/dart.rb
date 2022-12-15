# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.0.0-24.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-24.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "f78fe28b9a66b9e1608edbd8ead0e99aa18050f28f3337149dc0fcde7dc98237"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-24.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "df6dd27da2df54b6fc616277a5f7d728f282262796c4b664b4bb6877e1d37367"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-24.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "1af733e28fb5aa160e3b706a6e52c52c63d3b5a8ad857313ebf996e8341898a5"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-24.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "b18ac6507dfda3556ae48ad7d735605cd1ba2c50e76c4410b53de508c2a24d55"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-24.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "43351649429575afa006b9470eb72aea62bceb391c5e0b817a86404479a88934"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-24.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "9f026106e15692bc73a9afd8199fd4bc9bfaa11089702d6a6d894e4f261215fc"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.6/sdk/dartsdk-macos-x64-release.zip"
    sha256 "882497269dc6d7304c3367d721c170f20ff4661cbb055b9ec86c006fa95c2314"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.6/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "d5f55d1231ac189d15899bd39631f8391ef326111d356a63bf2a4dd14d7755e0"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.6/sdk/dartsdk-linux-x64-release.zip"
      sha256 "492c0e835203c4402e3d8291d12b53927f0300c8080aaf63a9113c204255a735"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.6/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "c97d1b3bf549690fb8c39392dd36b004795c54e808fe6c3503aa872850f79c32"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.6/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "61dbb462b48aee4f3184b6ecdd356632f39165ae8570fe77a62900a6444f702c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.6/sdk/dartsdk-linux-arm-release.zip"
      sha256 "c360ff64d1306ed5038a7df98142eff832abebc486d3e2b7f68b0fc53279a849"
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
