# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.9.0-170.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-170.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "f45f4f96a140349472747aa29656888e40e3e47046c4700ed46233f26a2b872b"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-170.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "af4f7506aebb98f89c7c9f7661b9df3a750a4da1f714e7366cc63bead166d0ba"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-170.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "a421817429725bcf41aac6f42ace2fcecef4f72bc819b38b1209930603b0b868"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-152.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "null"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-170.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "8970b7d679f69f1034c821c0334d977aa416c664cbb4686b4c655baac7dff3d8"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-170.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "cecdc7fac0b4fb085ddb6b6e16572e374c77c801a86999ad57e57d3b23cde6aa"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "39371df3d64f94f5b3d9c1119c3f549164c5628c6a13b9451b7b44859f1f9114"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "5080bc6f4a78ccce0e38e71e46476c08d61e081453646948f3f0c77177a928f8"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "0d58c010a361f3f1588b1c2f57942f7ccaf7b7abbe03404fef7a102eb638f09d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "null"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "78a3240097bee3b79b009c69ead22e1aaedededcbe093eaa980084c5661096c8"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "02adb724b0b684573f7630b3d79ef729f8cf9fff561f5170bcc195ee2477e1e6"
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
