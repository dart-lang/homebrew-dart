# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.10.0-43.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-43.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "a5262cf5fb862b242b185ca6bfdc86e072b77fa1cd1816e282c1979cf969f061"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-43.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "fa0a4c6590c55d34589d843b2b667cbaf606e454d8bc6e019d66b3c215eee05d"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-43.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "7a5399162f3917b6b5377bc659177280c6e866088188c81c0ac88915adfb217c"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-43.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "1d94831b84470ede0ffc596a34e095ea3f6d803bf0183165f0804948b3ba4746"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-43.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "3695cde75a2226ac5ee63719407a62379297b47f567d2bc5981122ab181e173f"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "df47f9b0e344ce55dc7fc36b34f3cad2f51872550b8487e3dc7f90f6d951b891"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "3cefd840420a352977d364fd2eafb8a5f3a8515ae4263159f5b1044d6ba35291"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.2/sdk/dartsdk-linux-x64-release.zip"
    sha256 "2945baab11cf7472328e5573713993baf917957fad691c1461cabd5a096e8311"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "6057db4cd909e37ec5f7dcf34ac0a65bc34fb41330b4c3718c43db1a50e8906f"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "250c7e7f77456213c6bdd90c731dfac77c3406a9832f3d2ba1719500f1af239e"
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
