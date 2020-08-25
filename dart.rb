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
    version "2.10.0-56.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-56.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "bce94f7466c8bb42a6343bdf3d9357000a71f609b0ca27a4e2b89ed5a8295e10"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-56.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "5c9932e3f9755a4b4bdbddb49ef2aaf9a951f0e5541e7d2c37f54c72e72fc00f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-56.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "b29b17bf6a12758063954e7a64b773f1c18cdbbb20e787a707332e335038cddf"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-56.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "de01e6982ad89c989a82ce1a0c3d01e563fdc4fde7693ef3756f07fe9ed7e1de"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-56.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "0f5c904776b5bc336dd6a672c1c4b8f7adb6b73e87be7481844e02935f7c30b0"
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
