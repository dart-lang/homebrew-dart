# typed: false
# frozen_string_literal: true

class DartAT380 < Formula
  desc "SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "ef3ee8c2dfc24add98b58f14305173a452e53e11d28e37c06bb01f5bd3fc7062"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "9e110bf8ae79b603a0ecc2f3aecfcf47d6b186ca75ee2ddbe4db79882ab39eee"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "122eae1e412ffae9b2667470ec025e5811d064847da95b22341b78445868f3ce"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "9b841ecd54c0df141c1c7d404ae0b45aa7fb1bf3b926484c0518f2a678498b2d"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "5e6ba94c6077b30dc9485841c70a4d8a6ffa34ea35ccd138b2c218089e9ff525"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "9a83fea7025762811432a62eb409554f1425c004f7cb24bba396097ee5b36488"
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
