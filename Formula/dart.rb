# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.18.0-106.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-106.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "6c8045b8126c2593d3e10f7f7b2eba7bae2a8b05f580baf3381b983901c4fca7"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-106.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "8e5c7255c63207cb24a5b6473f87383db067fc111032b3586602318da1e9a6c2"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-106.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "8f4bc035a114036595dfd939b72b2848136e47d243f423b831b40bbe719fb3db"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-106.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "83dafd92f6ef7ee8176f66bc6c55f0be04f708d7e6eae5ca5983b37d2e6e360a"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-106.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "8ab609a1b8dbcc812a0a9ae3b9197996ca0d5fb9c0cfcb353c52a7ee1991d323"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-106.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "1a6ba599950522a32a74a515a758238412896ffa8c0ba86ef38ee237316b2ddc"
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
