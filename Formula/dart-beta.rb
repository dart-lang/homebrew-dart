# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.17.0-69.2.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-69.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "58abd1e2782ea70bf4df52a165495562b93c5f7dbc17a9f42580a9c5f97f3e13"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-69.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "f0f108e90fef5a30b923235e5c43d7f83b9a41217b483dbb835a1fb86956fd0c"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-69.2.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "5896bc9fd8543b419870ced8b504b8f33b16c0a0bcf566f3e419e3b35db21006"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-69.2.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "ff4e473936dd0d15408027dde13a6fc29ff1fea487b3fa6d296b5867d68ef5ce"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-69.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "ff5ab6b960a5511eef506236ff5e4b4d115f2786393b59d615c3a0fc242b0639"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-69.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "56da37cea8b4bc70b17cf08e1b582dcd35392c3611140cda04dcba34bdd4b2ba"
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
