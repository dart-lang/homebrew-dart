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
    version "2.10.0-45.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-45.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "abc8251c8681ee5c79ae769f5397dac1f736b26b6f726cd9edc6ccb49bdab01c"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-45.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "c4db85a9c34b7a5d6397f4c5ccc6299b4a6bcf8f4497d20b188fadabf7ade75a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-45.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "835f3fb8921ced76a7e5c81b16ff3598698023d8505011879a094ff62e060c46"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-45.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "a6bc58ac3ca378f173638c1317727821da59209b16e9fee219d7368b7b65326a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-45.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "ab672f1d21d1921ab8a64207020895bbe194db5de391b8d4126079a19e221993"
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
