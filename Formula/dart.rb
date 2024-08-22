# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.6.0-165.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-165.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "48da35f90e4775680419d57e6eee084f50914370ec855150eb576a1271c29080"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-165.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "7cc13061a077f5c470bd9c23ea64c4abfa5e822b739dd3ec404c0cf208e96cf6"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-165.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "ef9b0af05280d899e3e7655a41b6ab02bda3711c3f804189c1b7ed577558ab32"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-165.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "7ab04a869293936a7c5cbc0f9b59dedb188ece813dbe388f546a91359926fa32"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-165.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "011320b40076df34f84f6726296246b66ebdd0ac083dd144faa37b2ad9c0ef61"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-165.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "8a84f3cabd9566e7456822070e778b3ccbd776f0668226726e30bbac40560706"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "4c4664d675f69440b6e5bcbae80868817dcf657360ed233a78638060721b67a3"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "1083b8fc5dbd9db3d3801de5ee05bd53eab6036acd1572d5ee60e93d29b75aee"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "ec7cf3dab7b7b19f42bc5bbdde9f04911260ca828604e877862046ae10afc27e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "fc4a0d4970b6b91a0a8ab76c52e09e54393aaa9b0b53113db21e86e2a2f7a787"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "1bb01530d5caa7d623f3ea30307aa129d84e8fca9d63b36240ed8c3bfcdc9653"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "bb3633bc6a32cf676b9824421bbb1639c05c821dc3fde9727f62ba9eaf349ffe"
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
