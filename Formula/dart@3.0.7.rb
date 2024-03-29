# typed: false
# frozen_string_literal: true

class DartAT307 < Formula
  desc "SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.7/sdk/dartsdk-macos-x64-release.zip"
    sha256 "cb8e8bd8dedef5308795cc3d4917a00dfbcc73742aafb0d95bbee909a3ef398e"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.7/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "bbb6625d89fbb910543f185cffed88aae1bdb8ab1e487496f3a5c3d18159f979"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.7/sdk/dartsdk-linux-x64-release.zip"
      sha256 "cccd5300faa5a9abce12a5f77586e26350028cea82bb4ff8eeb55641b58a2e1d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.7/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "e2e94c38f93a1e8eff4fb27ffc5c13368142499b0e8283991839c4d63efb0658"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.7/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "2c8eeaf0d3da60c4e14beec45ce3b39aca754f71b9fa3fb0c635ee28d6f44708"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.7/sdk/dartsdk-linux-arm-release.zip"
      sha256 "3a15d42cb1677ac5e50a23045cafe3bf5db2855a5287a3e9019b849fe8477897"
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
