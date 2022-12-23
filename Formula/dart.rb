# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.0.0-55.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-55.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "fe90b6fed58dd7626d97dd36f0b811d059fba5d9799e3cf825bff5dab53745c5"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-55.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "eaa97a83171e1f11de016e57e87cce2b019c5ef26e51a536d625a25bb5582c65"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-55.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "2bd2d59e7f176b3082bd5a328924800bd9f06220d01858b7c55bac9a3f98cffe"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-55.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "2a31b8052520041a58f0558063ddd4aeb41c6c2b8d2a85905ca8de049a1913ea"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-55.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "28e6ed61229f847bc27328a944d5aa747ec541cfb8c66f80839fdc01a63b315f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-55.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "4fb4cdc357a9a79fa255e5b1ee526f02d6e7fcbae9457c5e954e786c14c5f4bf"
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
