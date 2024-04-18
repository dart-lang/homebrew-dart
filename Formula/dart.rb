# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.5.0-69.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-69.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "01df5e27bb50c87fdf41499d2cd118ea34591e59e18a55b4f76bf1a47ad2b05d"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-69.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "84ba375a9e6b0392460615b83973e9b70b0c693656ac9bd2888e1712525a522d"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-69.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "4e6c1fef034c660eb6d8be6008d17756da27ecea3b55ae6fd2671bb26c4c7904"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-69.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "20cd453d06854e110d4cf3a9b275b29a4df61ae0a6b6e1cc031b945c4211f42b"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-69.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "85624afd4be52fad60a21c991995754023053ea2336eb6bfa30d464b5bd8cf5d"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-69.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "721830662909690ac7f3933afe4e5570a5012d82bf584126bfa378463d972344"
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
