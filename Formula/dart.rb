# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.18.0-99.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-99.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "6964783bc60e4225756c6c48dbaf59c7b7eab4bfaf399725d630dfcfd4b05c90"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-99.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "e67c46662c01e07918bd7fdf19194a938efb6e31b88c63cbe1cb0357b536dbd7"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-99.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "b6899ae1dea1204c4c643313c01d64b785af750bfefee8e616cdba7810fbafbd"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-99.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "4f2500fc271eaf35208c381da594c112338f2acd597e7d0b852caa277773a058"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-99.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "e505140a5ff57d3a859cccb2682dd430eff2e008673fda42519525a23b9f8531"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-99.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "f148970170657ff709b7d14d8b6ffd7fed272e6dafc65cc6b9434b09f89bcc6f"
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
