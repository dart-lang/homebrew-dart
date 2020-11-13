class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.12.0-29.7.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-29.7.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "20229cf26233d2431bb0418dc5d27347d2bdadb784ec37d12408eeec94de2d96"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-29.7.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "2f935883e579d6037d46d079c2f83d52defbc20c9954811d2257ff7d728e42d7"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-29.7.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "3b927be3fed6de8351ac1d08750bc29780dfcb7caa91d3541b6b79df6a69626c"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-29.7.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "cb40634480c1fea698166ed9cd18cded648dea520179611011d940f1834d3226"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-29.7.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "1482b4d111caeca5cb90acb66dab2e8a03978e371a9b2d67771dbcc4d6910708"
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
