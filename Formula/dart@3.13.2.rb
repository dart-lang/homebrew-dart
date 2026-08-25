# typed: false
# frozen_string_literal: true

class DartAT3132 < Formula
  desc "SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "a7b7922873059009b29e8bd9decf3e6fc658df8bab5ef439de5bbb20be6d7b33"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "1e79f51341937f84cc1563a3fcad4a91706e35dee72bda69f4e955065c0e373a"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.2/sdk/dartsdk-linux-x64-release.zip"
    sha256 "28951c9f6bcca005a73aa24cd5e11478dd6555f53e8e96a33ef4d868b6efa9eb"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "e4b2dd93bb3e7da2a2c5e1215d94c5da2e0ece0ed41b9f26c3d7e98baa659c7c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "c34c656a004d5117fdd05165a4cad56540900a81b424d98c45ec8cbd7bd50e95"
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
