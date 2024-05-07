# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.5.0-128.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-128.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "593481f3f3208adf344acd9557778fb56eacac78cee669898858155c25f9ec4a"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-128.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "648a653403a6139a0d4c8fc59d9a8dcf820be5ceaf0d68cbc02824ac8305c3ad"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-128.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "2ba9bc662745ecea474ee5f8330dc6ffee05d78f559358f7f1d10f14e0dc064a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-128.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "d51aba47377f4ad200d043695ae383710ef843fe030998b466462c732cbfd3a6"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-128.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "65342a210dc37bdec069c4dd457fc498dae20a5afca4ff5db97d02b94c07b886"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-128.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "99930a1ca5e569015a741bca8539b3fb254268783e221a9e6576a5020337688a"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "62285d9156bf6fb4439420bc327ab772df3a248b5d2df978284f510edb5d2c4a"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.4/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "01c594a2a7dc1ad98d210a9751aaf0972c35b13992f0b1043e8bf93361d60b51"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "6773922a60ce6f3b259dc4877c15f1cd96f325ca48015120014f64171708a7b2"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "5207b171a9d6d88bd711e6022a101d61323dba4971a1653f568dd34d052ab248"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "c3473f681de8717134212c4cabd98ef25ec45c0adddd34e3b0d99431a606bdc9"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "84bd6dc6036993b8d2b41a2012d914a28d9f2e3800fd63ae02d21fb56c467c6f"
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
