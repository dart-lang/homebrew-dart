class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.10.0-110.3.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.10.0-110.3.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "56969e740d3f79151a9be110a7e42332294703a23ec196e4ae1cdaeb3107d7cd"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.10.0-110.3.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "8cb2ea7157dbe75c0f5f3560b28cfae95ab621995e0d7a89b36730827664b23d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.10.0-110.3.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "14e4cf4483be8a8390dc671a8c37af34d33898fee06c9ad9f7f50927e86d9f21"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.10.0-110.3.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "07c3f068d13662a125a8976032b7b8889e1218f4287a35aff65988770fa402fd"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.10.0-110.3.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "f257fa7fc48a4b1a09ac25fe8368522285738c94f68fe4be5f86f3e8db23fff4"
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
