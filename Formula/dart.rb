# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.3.0-238.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-238.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "6c3e9ca50fed8d25fbdf5e569ac99910ef94e72bb4b0d3fa46d4f73970634cc3"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-238.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "ce4e1317eee5160e46c8ed4f7ee8ff6951e691d2f920bb085dea0869fe6686a9"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-238.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "900c799531cf29d2ef9d5b1160771ea257f88c83f80789e551b4b3db5ba9c6f7"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-238.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "7d054233cd80ca81d009b2c1bca9e14115159fa556f84644c6ad73fe62a8adf9"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-238.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "11aac2e65d178866d9b03977c8713ea8ddac0672f550bf17803af4e128e6624b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-238.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "9ba69f5d18d891efc9cdaeeff4cb83276115cfa551472a6599c721a857c55ad7"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "716239fe2fc0237e5a31446ab5e3c95a8550a6bd7d5c5ad404c2dacd3aa4953f"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "a35017cf51e1e2b86801fd9e0937d7690559f096631b57134527f51f2d6708ea"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "3a1903a8743422e13e93fb3f497c179fab5658ae32b9151a7baee3158461e0a5"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "a6c19ad36fe3a58934130bca0e0801c9addc692aa2815b4bd9dda556c38859a1"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "dcf3c8116070c77f2376cbbd5229712a4e6874ef66438c0611e2ef23f69b2862"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "2bb8a9faf7de11294c6c0f327cb7c328357f8872a5112e7d3abe6d35bc5d8199"
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
