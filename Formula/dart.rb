# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.1.0-289.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-289.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "71b6fa4596dda56652dcbf792227cfee8590bc0aba6cf43819d9da7bc62b06c6"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-289.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "bfee88bc5b0318a6bd2151f71df22afd9d64cb71dcf4c5b33f4efda5823296a0"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-289.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "6a87b6744ca3d1a42051a4d450d0db2f2431b8d322d5bab739f02c36eb2eb27e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-289.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "92b54fc6901512030e5357fb7ba932a2d1e9babc971f7cf7bddd3ea334ba9930"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-289.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "4a2908fa07b35650e174b83a5a1f2aa0848a43fa57c909109c35d5c96be3c369"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-289.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "6a33c28f33105668826c3c0563b6b88b8a2f329b420299de287ac3e81b8b5dbe"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.6/sdk/dartsdk-macos-x64-release.zip"
    sha256 "62608eba79360e412b55dd1f784d99f75acc0662600c11d2f47af16813d7aa29"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.6/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "2c94a22de2275b74452d3c82fe25887f000bc25972e91d01c64165f93c434572"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.6/sdk/dartsdk-linux-x64-release.zip"
      sha256 "22138e69f9880514971f3de366902ddac89a5b9c2a593295f18fa1ec2f79e1c1"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.6/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "ff47051e29ffcea6dccf350927517b99e9f20149c4e430b4e3c25b0bd51b70c1"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.6/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "3ee243327167bf4675581ae4748df3c822b8600324b17ac5ed0b6cd14ec2981b"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.6/sdk/dartsdk-linux-arm-release.zip"
      sha256 "10c6242e8a11b81424b6e5e0417c1c7be8eaabead585c2b113055b3236ff7434"
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
