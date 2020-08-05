class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"

  version "2.9.0"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.9.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "4083f92e8680f2196ca6007e445d192c3db3e5408e3de1c52545aa64e6d74f87"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.9.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "e88ad49f39c3a9f9584980df88e2e62106141469e4f638f67f0c74554516b7cb"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.9.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "e498f94c35f55628d6497fe5b322c108126955d1bd6e6c9c146501818a5f7af6"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.9.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "8d1bfc2ee538d8058701afffe8f766ecea2a8d6ecb2e47bf92a866838cbff36c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.9.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "45b1d2f9808fedb38c1c75cd5784552d7b612c0e8177327a7d14fcddddef15a1"
    end
  end

  head do
    version "2.10.0-3.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-3.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "6bfac4ec7e6711268387e0f37932e7106cabc1b657fac748bed22e24e501ceb8"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-3.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "e07038bc393c48506b520f02afbffe42214adc837261b1dfa0b3f156642fc38b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-3.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "6f02ea057f7a530d2ccbd2c14d4dd8ada691a7a42dfd458a921c00dcc5ade33f"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-3.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "fa3e2ef11bc96dd2904c57e90ff9b80c8318fcc7775b06f0a9e7ef94b5210732"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-3.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "03bbcb996198657d05297f22bb36fa305f0d420519c7d1476515c568d23b4e9c"
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
