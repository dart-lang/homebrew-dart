# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.0.0-46.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-46.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "3b801a6f3c2abb5f8ac34def866e34e03e20700970587755161dddce58ad87fe"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-46.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "a2206f30184e6ee01ad382466163b4004f15e4c4d9f6793f927dea2a41d8905f"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-46.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "b656a8204c8f734fbdb4b0fdd1fda25d0dcfa8ae4e30b199e1bbe0c321dc4400"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-46.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "afb7e698e69a557637e08a6d7f3085e17f464bde7fdf497cff3b418e756f5994"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-46.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "7d0a190d2fb77c0b2912d6363682776e1baaa545f62fbe48b83e7ff8634638e8"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-46.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "f0c97615fd8c47fe03db1d7d3043c1d7c8269c176feaa906c4f8208beaae4b65"
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
