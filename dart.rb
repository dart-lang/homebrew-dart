class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"

  version "2.9.1"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.9.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "f7e41307222fd9b856acefebb6bc9137c5af4ecbca062736367b83f4b3978eb0"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.9.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "8e092105482e3e1be90af44962e3b7973a20cd8f71aa9f6e07199174a58e0eed"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.9.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "8492ec94a07c6100f1a097864668e4b9063f3b1ed9f05c01dee2d59158ae6a04"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.9.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "bf92f51f688ef0bbd4d7c62c7ab391da3f632cf12280bc67a100a09a5b89cf02"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.9.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "e393c05136571bf7c4879a2bfe207a768be449a3d0bcc8a7ff700b01c4330109"
    end
  end

  head do
    version "2.10.0-27.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-27.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "2988cef3968154bcbbcb0dca08171c86509d5a57310cdae75aafd17a3b9f158f"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-27.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "5002e4b1a9c73ea0619f2be0ae0f468d0906923d3c13075987e79641f985a2e0"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-27.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "45fcbc89aafe1ad2223663f63e5edea3d4b9a7230b884170d42f78269a51db1e"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-27.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "6468423f396f851867cba67ff06dbbe348f8a5a10d218985a3c32ae237fdd091"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-27.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "3ffe4825a6de0ae119224e5a3f349a24eda291815f722d26b126588b39f052a9"
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
