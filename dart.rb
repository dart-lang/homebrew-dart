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
    version "2.10.0-59.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-59.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "2d1d5cec34e563fd03e4410d4167fcb2eefcfe750314af16c218f76d21491efe"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-59.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "b3252fd451b8858205a8b5067431290bd338f2d2de7b305fdc531ddb0d448e3b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-59.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "cbfaec1b3401574634d270529432ccf65ea73e6bd182f07b70c504dae18ea39a"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-59.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "84cbae68cf4d4aca73bbfbc0885a3d4d127a26656069e0eff16033dbbefdec30"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-59.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "a69459c9688c375710b327b562655640eb44d1de64ae377316eda32259e42a37"
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
