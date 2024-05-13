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
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "fc7c7c151c4bd2ec30d8d468d12c839c2be13c7569355ea60e0914dd1f7c2ff4"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "e7b6b78febbe2f6ed8795af03a90f19331ce97115107199119a113800d441c86"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "631acea14a87a3c5d34f4fbd67ec8670cfe1345cbaa8fb8a3c45095880858620"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "5fa0132def556dd45f163221dc0a5715f959ce6f1332a4d4a6301c0f849fe5e1"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "227562fab85cd9e7e842d282af376af0b4a717010b568016e0dd3b8524e7ac10"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "5553cfc3940dcece763683d71b23055bda2fcffa9fa1eaee721c1b5af2c73f61"
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
