# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.9.0-333.2.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.9.0-333.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "226ac3f3ebe805f3a7abe8cad5d81727b6fcf2fac42dc8e475c11426f1473c35"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.9.0-333.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "28590e493407cce73134a3e03672f9b0bfe5edb8dcd5c755bd9d1f94f7ad4cdb"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.9.0-333.2.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "8e531e3020138c998dc997665b86b335e340875823518b0075cdf1613420930f"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.9.0-333.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "56f28331e553e0550c859b89b4e497772f35b08c2456317d4bd7601c7fb40364"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.9.0-333.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "d1fba196f4d11767051da730f1d47eb23fb6a87cb05de7b98aa779518cb71227"
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
