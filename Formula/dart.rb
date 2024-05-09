# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.5.0-136.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-136.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "f3a0b95dec17b9374147a7a60a470d85077abb7f0b80a1cc3ba3a0390ca45421"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-136.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "a2ec510f0f843c4b5971a720bea54a2ec7686f436173cb62e32fa8d6486eeafb"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-136.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "4bab6f3340b52efba176755a605795f3f12491590965d056ec23c18c876f5010"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-136.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "8f930c859e9834df619907006ce46fdc219b3cd54269a951b2292c6e5da00434"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-136.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "057c4243545f3e7ab0d89303e078cb937a520be494fa9f69ff3f8bb895ddabf7"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-136.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "c3224231655f18be237cbbe701864189d9ff19e0e0a08c6727604359a3dff167"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "62285d9156bf6fb4439420bc327ab772df3a248b5d2df978284f510edb5d2c4a"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.4/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "01c594a2a7dc1ad98d210a9751aaf0972c35b13992f0b1043e8bf93361d60b51"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "6773922a60ce6f3b259dc4877c15f1cd96f325ca48015120014f64171708a7b2"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "5207b171a9d6d88bd711e6022a101d61323dba4971a1653f568dd34d052ab248"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "c3473f681de8717134212c4cabd98ef25ec45c0adddd34e3b0d99431a606bdc9"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "84bd6dc6036993b8d2b41a2012d914a28d9f2e3800fd63ae02d21fb56c467c6f"
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
