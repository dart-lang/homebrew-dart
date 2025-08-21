# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.10.0-75.2.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-75.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "cbe84b341d4961d685e2a687fff6303050dab1ed338ae02068707438f5131599"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-75.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "b47aa057aac0c41d2a12fd2c051f63829b99ce21a4231aaa448825ce98f19d72"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-75.2.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "4676a8e1596743d8280d8d3262564c318ae3b13f3a186b094eb05eba95378c12"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-75.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "9bab193cf5d2f0f13e26ef61bbbbf49de262f69677e4e343cb5bfe7f3395066b"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-75.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "3a1775a100b5a626805c2c1186ed96786a7f426be173ca30782df8964896b32f"
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
