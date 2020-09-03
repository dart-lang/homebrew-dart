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
    version "2.10.0-92.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-92.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "613843026bce9456cabc48d374489479dc3e251bf2463ebd9fd9dac891495d27"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-92.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "be44024a49e368c07cca1411caf07fdbf6784da5e602b9996414ca511fd9c491"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-92.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "29135ff808e2a2c6638748c88bb96cfe9c45daeb83ee1c919e63b555709804e5"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-92.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "ad46adaaa699ce0a5687ac8492d05a32feae0ef930d67eca0c91ed214f29b2ae"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-92.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "31d29b10b486e30271b7a23414f971b7762f247b276e308820e8b9848cf3c133"
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
