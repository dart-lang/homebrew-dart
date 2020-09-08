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
    version "2.10.0-99.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-99.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "7cc4206939964a17b246e30ebccac645a383f370db9a327714f0cce171d20c38"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-99.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "701d1a231026c6c3a4599d74f890bff3ac45201427e029ab25d9940b13b6d672"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-99.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "6570214c6025ee60863bb3d0bf6d3b43ab912f648e265cfa801ff6ad798bb268"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-99.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "a11b668f7c899ec6651a063445ece17d0cd8f2d7e4a70eec3ef6814a57c27b7a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-99.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "17c27d8d911766ce6fabec37478d5113d65d09e3b0a1488e357df7faf959b314"
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
