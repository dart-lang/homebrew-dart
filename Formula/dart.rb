# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.1.0-94.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-94.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "fa1207b3bcb4c7721edb975a95ab61cd3605627b9a4afcd1169b270cd718e568"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-94.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "a03f4765f1ca0fa63b26c48303128ec2ad5e3eb01c61ce03f9f9d1548a5288e2"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-94.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "5243c80abec38e4fcc2a4b08c5a7042ba600486dcf25009403e9290b1e182718"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-94.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "83aa3d271fb4d3845884f0b5d34a0d50718f02dcbfe71aeaeaf13a299579848b"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-94.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "04bec0328464519c9d3f84dca0022b8ccde0738eea0428bb29ccc575ae351a61"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-94.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "8ea08ca19347d2da542d49d85d65877c21696c4b8b6ea680785561aa2cd6c4f8"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "6049cad15ab9362c98d87ef20ee6ba2d80b393bfffeceab6c1dfdcd24d325b29"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "67ddfcd369e8a0d7b6875396b4ce055d6b54994cea2cea6ccd190fc0c9c406d0"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "a256514a66cbbb8e151b968a7098a72c81fa9e4f1b2680f0f7d046cc64762665"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "dc7d1bc145f04007337e556ab56bf4bbd31195368de2eb5009033ead0d630d9b"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "4dd7b18b6494fdac16ca6104533bb271af15c035e8558a0e4a77029fadb4255c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "d053f4e6ca1be368e6b971bca05c3cb5e8cd6e977b384f6d52a7d580311db423"
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
