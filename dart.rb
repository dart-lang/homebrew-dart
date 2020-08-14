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
    version "2.10.0-7.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-7.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "3b823cfa79e8395c0184dede4c9c61cc63711be6d5455cc7b129175fec33498a"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-7.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "340ebc9c524481943189c5f2f69b63a546a156821f3526a3fe0ca6df1a4d7939"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-7.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "0db26144b6a989fcb088c41c0e58738ea897380d53eb3941056c3a8c87571825"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-7.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "17d90984b322c1741e447fb4f6cf66eb7a11e2f340c668133f97ef67c16ca1d8"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-7.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "72f1a723993e9598b254f99739f05cc53c53dfff54c27a0ad9412eb2a647c959"
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
