# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.0.0-89.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-89.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "abd4cada9114251dc782a8a3d07815812a3aada776397c4525a748ad9e78013d"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-89.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "eef44ff02876d65276c2ff5049dc13c31d67fbace905ac22094acac61165afa5"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-89.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "e0cbcbf1a034d1b619adc2102730a572151702ef9d6cd5ce0577ce87e94757cb"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-89.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "b30b228701c5737cf14bb5a9c80cbde7746318f3fbeded7035110c6d560a23f8"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-89.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "82014ab3af959d3ebc6dbbfdd31bc42725762febddce3edacedcefaad0c2f075"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-89.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "370d0d4bb0b87e46ef35e619239200ddb5c9763069b8a1c97f91c4b01a80f244"
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
