# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.14.0-166.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-166.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "4195a3183885f607b12b86614b2a5d725c3bafa2194fc3118abd8205a037043c"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-166.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "26d835bcd59d8c3712521aabd841fa913f26304bf0a6333c702ec35786b6c102"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-166.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "1f9370df450fe92c28296dbb068469ea8b6430bd886103d13a8dd9cfb6296464"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-166.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "c88f0293a6ad2d7369ee68136b5c68f2577904df50dd194a0de8cc98da965162"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-166.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "8f624112344faa19b0eeb8f5883b094a5a548cadacf424bc7add553d9a827c16"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
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
