class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"

  version "2.12.3"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "a47e33c231b6c92fbb6ce0bea6bf52060d8ce7b9b6ff507d30b27a99f10009df"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "5e45b19fbb0b695f9b1a76dd1b6659e943ee5ffd13a4962bd1c94005f2d97538"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "229fa16f9ffd86ab3839060a67872c6b6dae4ef0d5de5bad2c1a59285875ea33"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "0b80ea972d3c1e044af76221ccf3aae477afed87f4f7a6858e4b77bc72f163a4"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "b85137021c22218731e621947c145e367c722c982975a8313cb3af03eda47715"
    end
  end

  head do
    version "2.14.0-3.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-3.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "34785c6b109ec5be5e2b0013d3b5f44ca171095bfc70cbfc1d17b1b7c77eafcc"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-3.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "50b8a70798398f46aff90cdb0bb7b35520f7f2c248a0a2cc7bd748daf7da1c19"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-3.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "a5fd484ef182a298c93cca0581e7e193d84743307798bb41ea3f8038eb42cc15"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-3.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "785c151bb4494464ebb9fb810dd63360625dcb0aaaabdeadfd467a152ddaebcc"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-3.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "2d52e95da6314f1f68a3c4672ad95592664ee14c6a8541b4914ca0b09786b875"
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
