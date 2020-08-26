class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"

  version "2.9.2"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.9.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "c11a4a2cfffe13126b09339d02654a76d163ffbb12a792bf14e57961fe965a86"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.9.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "7c1a45fc49d4f852c2500dd2272a327c2aa66f62e5fcfdaf37e80dcad0599622"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.9.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "856c418f1f42fcdfa1edee66432a46fc7a81b79ea9f2eaf8687758f75d8dbbe6"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.9.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "b4f9e95c8baf77c5e0b6b00cfc6b359823b10812e9e339742add71900f8919a1"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.9.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "317bb2d15cc016ae02c451a90fedd6dd90515f105885a10b24f2736972606da9"
    end
  end

  head do
    version "2.10.0-56.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-56.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "bce94f7466c8bb42a6343bdf3d9357000a71f609b0ca27a4e2b89ed5a8295e10"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-56.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "5c9932e3f9755a4b4bdbddb49ef2aaf9a951f0e5541e7d2c37f54c72e72fc00f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-56.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "b29b17bf6a12758063954e7a64b773f1c18cdbbb20e787a707332e335038cddf"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-56.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "de01e6982ad89c989a82ce1a0c3d01e563fdc4fde7693ef3756f07fe9ed7e1de"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-56.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "0f5c904776b5bc336dd6a672c1c4b8f7adb6b73e87be7481844e02935f7c30b0"
      end
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
