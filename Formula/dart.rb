# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.9.0-333.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-333.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "8d440366f833cc4a74a2e4c0364c6816990a69d5d1f93d2e95f3e9269f110cc5"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-333.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "97faf17675432f0751d835b4a9979444936b55bacef8d45f5d75e8fb7417f46e"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-333.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "81893bc99e8a8f206395c1a10eb5969203dba32d2bbeb178c742364aaea3ab41"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-333.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "8b60ac63c4766dba9d82303d3a62f44c476b0c518216dcd58a429761ab3bbd54"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-333.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "e29ca4c598576693650d01c390363d39081217361f345c500ee8ad1ccf5f12db"
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
