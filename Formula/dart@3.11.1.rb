# typed: false
# frozen_string_literal: true

class DartAT3111 < Formula
  desc "SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "a4b4ce293e0b66d232b31fc4f51f5edf930ecf5ac073b1ef367728f2d1f98d2d"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "2ff517ac1a40700f52bf4309fb64c0dc7aaae1c4e38927bdb9e868028d6b02f9"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.1/sdk/dartsdk-linux-x64-release.zip"
    sha256 "cffb8fa4afb777c2630c66311bf59eb034cd3ea0c7f94ad326e1a62c6aa9c272"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "17645c94014b1b46a100e4135b64235cf9c19f9c9a3fb814959ae8293f35e98c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "69afd778175725c9ef25a7d6ca52c1a84f0e803cd8e8c39b76ff7667e7933d0a"
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
