# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.12.0-288.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-288.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "9847454b55fa5490ac44b23658d21f6a965a72ee573f067e85ab83254c6e0089"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-288.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "c8ef2eb941c688fc3eccab205246062563b0f91824ec87cee5e39e0fe466c790"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-288.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "6687420094fa7da7a8e984b48c181feabdca166f2fee463a862063c4d43664f1"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-288.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "508044e10e6cc2e4369786a2dfe6f4c97b953aa49f3012eea1a310a112a5d76e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-288.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "0f5ca243a4993eef6807ed6257950cf81c86730349a319c22146361f484ca022"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "1874e34c72666c83dfb006c5e009b18c31134b0f580f4e3fea519e7287b5c6b0"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.4/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "0f0c99b407992ee697d8c1553f384446215e5f8e7023db13738636495a29444f"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.4/sdk/dartsdk-linux-x64-release.zip"
    sha256 "52d62f05b007ccb7117cf41c19beda1c87c144b27ea600b16b4c9c8ea8fc8fd4"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "c35ba6f0de1f5ebbf23506612bffc347c7ba94c3a4c75110cab1157892166d3c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "cc095a2dcfa4351c24596108143dde3cfaab0209c288a92a39047ac468d921f8"
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
