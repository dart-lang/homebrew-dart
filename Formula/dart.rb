# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.18.0-109.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-109.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "ffb6bbe029bbcd1f442c7037d9d0a1b35b05b00acb47adf4be0cf70346e51e20"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-109.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "66d38ffd6bace1682c50a9df36bed71c58a26dba7bb30c6d8dc0bd6bec01245b"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-109.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "2cd0c60359ae9d2a456543dca1e91f1249619fe15db6f2d8342d6947e6fe5dca"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-109.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "91b055e5bb1426f7f964b9f7f21608d1df9bdac513a3455e0b5c5205bd299dc2"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-109.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "5a6223071e484d99f58d87bb6dfaf27778390d9a0176dd455613687bebbd30cf"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-109.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "fce8378250b8b6c9bf13d27f72b8599668a64b6bf51cec8b25fbfe15c153aa46"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "3f06b15101c852145608ecb7215746b51c8ff4bb6c72aa1424f3997debcdef1b"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "5977f449d4841cc68945f54580acdbf526382c18dfd713b93a48bf77328c10c6"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "57b8fd964e47c81d467aeb95b099a670ab7e8f54a1cd74d45bcd1fdc77913d86"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "616c45c1b706becb0e48be12e4ee23a8bcf17541ef6d577d8b870b372167fdcb"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "05a1db0fd84585877d6180858346d7c53c7ef89433667db3b85f3f2e5fa7036b"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "c522ca1744de506276d19c1a5c120526daec142d2d7595d6915f77838066c2e8"
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
