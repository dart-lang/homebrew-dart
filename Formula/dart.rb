# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.0.0-75.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-75.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "0e81cca451167d491e9d9196a0d8edf1e449de5f49649fc949f4587a18b8c16a"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-75.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "8d76b5e64559b15eb77d26313c6de5bec7f2230a4134af52db89c4f25dac8f6e"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-75.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "a7a806e2e25e54fa88e35f5fce7c881c1716ce3d585d431eb33aa9fa70fcb11a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-75.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "5020c08d713cb37746149d9d44abf5e2de950d5e191a154398883b8d327f0182"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-75.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "71d2a97ff0067fe2f1c7e7dc83cefacd8da0af659c4f9b62a18fe5872f3acc5d"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-75.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "e3261cd15b5efc38b3fca1d7d66827de36d65f8ebaf392994051feaa79607d14"
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
