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
    version "2.10.0-4.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-4.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "40ae2c44877c0a0b17c2c184bbde3e964809ceb3cf9ac29bb543313875373805"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-4.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "816aac451354f3dc0817b95af45e55e0cd1ecfa9fb65e425676417ea6e121755"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-4.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "476e1c0d538d31228696b85fe5e6be237a18125e12dc1aa5ba2332fb07be34d3"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-4.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "27a3073e49775769f78956d460b2b0a714235d82899a373e5fe5e7a1304f8579"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-4.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "fd074f2b9937d242abae078419d0fb498ae5c8ebdbf2f1a4d0ea76db788f36c7"
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
