class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.12.0-259.9.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.9.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "edb756d2a796cda8d5d9778006e2790ba0a9cea91e56a078372d026e99ed8790"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.9.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "a65f109759b34fed172a0420e2ec7dc60ab8797d589e9781d844d1506638f7f1"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.9.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "ee972626319127e4fbdae73e79937906b13e7fd1dc25c77bc78b43860d0c6446"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.9.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "5d36adad59753c2fadcb8f5a668e61a590834a476d2440568f06155a308f24b1"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.9.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "bc99917a79085b0236891494f080265783f83c56441cccbab924714a6591e49e"
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
