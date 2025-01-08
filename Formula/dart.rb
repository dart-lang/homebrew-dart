# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.7.0-301.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-301.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "e0bf858177bb1b13b6767ceaadbd02b43a266a088cc46a027707ad8726ab23de"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-301.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "8444fa15f75407756c68c188f30027a64e0cd8a1608d09e0319894a07fab21a8"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-301.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "1c75e779ff3d407c912bb40e8c8d91f811879d6822648c1e611043edb5c746e5"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-301.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "260d6fc150c61eabfc2b9d1f95bbc2f2d85ab6f579c7eef05c70865f32ba942c"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-301.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "c5780adc42a6a7baf8f76268e6cf6b9695a62a5f59bb189b6da89a99c0605245"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-301.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "4333fa567c4c8ff9fa7bc776a26e0bb9aa4431768b8b090f35140082d3ec4e3c"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "b797e4e9ab31192264a9ff8d148f3d58f05f0f8cdf82f04c59fd67832c55daff"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "8fd91cb89fe883c448a26e6e34d861d51d9451976c56db2287c5f2df80191ff4"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "fbed37419784149c93f3ae444b9a9d1b5d5b73a521cbce731899d601d9b435b4"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "23dbdbd8020aeba52c694eeaebe4c29bc2be5476056b5750bffbb2d231371584"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "9192cc5efe2af1ff91aae692950550ae4eb649656e5e003c76b4ed55c328154e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "2792acd3abfba7f3d61fef7d0973bbd8069f5f0ebaa3a4bc47222cbf8d4811bf"
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
