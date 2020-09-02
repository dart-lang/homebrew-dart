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
    version "2.10.0-79.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-79.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "ef28409514884135787712340b4fbf3839659cb9801b0532e95cbc35abb5b363"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-79.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "37c98f20bfa544a2bc47f31152748445ff46fcb9e8cca1d843eebf86a15ab521"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-79.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "39d697e3493ced1b933c5a1b337bbd3375fc4ec263b98aa084965aaf104eb5dc"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-79.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "d20a296b6a64945a1ecd65a991abc706a11b6fa454bd5725c87a5ef77b4d5403"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-79.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "9e96e27967d49ff9ed8ef2b8926dd72fbc84e9be521e2c30364eab7b73c18f57"
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
