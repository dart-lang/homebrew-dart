# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.15.0-57.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-57.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "6bba16b0f9657edfc0cac2f75af8b2645217de7b18a5a66c7b815e3c052ee277"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-57.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "5d416cd4085e352752ffef39b5af5098a6a4f75f395a3da3d4fc176a182c830b"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-57.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "c37457ff0bec452f545025df5467a1f7bbed278281d1f8bd44a72c61a8a8cf75"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-57.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "739e07617470e2e36d7942cef6ce71695484f6a72233be16e4f418128532cccb"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-57.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "cf33e91040379ee710d6e8b714d99a5b5d3f44f62a49ba5d761e656ec272d6e0"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.6/sdk/dartsdk-macos-x64-release.zip"
    sha256 "c978361a06576e3cf9602851da3d7c094b5c11661a880225aa4b64ab73cd5dd4"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.6/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "6691d16a048c5bcb6554ad35c0de3fe2e599d35a7538bb9830d3d55d366a6bb8"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.6/sdk/dartsdk-linux-x64-release.zip"
    sha256 "f80780c01ade17b789cf4dc2425d662f63bdd40eceda53b36c0d46af650de41b"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.6/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "73753a2e009505a2ba0d0c0bd449e248001a01984c805a3fcc19671dbb9616b1"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.6/sdk/dartsdk-linux-arm-release.zip"
      sha256 "9c170d73f35f990efceda4c141a062a14142f0b7b45527a4947c25f5d3c8af24"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"].select { |f| File.executable?(f) }
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
