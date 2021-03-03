class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"

  version "2.12.0"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "256a442c5fca15bc6af9b62a0ed2d409d416272555347c5df8faf8b20126e6d7"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "31e075b344797c066cabcbae7ef0247365f95d25acaf24be569fa12c92fb67b6"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "465dccbbbda6e27168f9c6a08498a681d4c9edd364f9a2ce5191e72abc93a4e1"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "00692dbc7ad3cb925fc399254b821458593f6b4bf4e1d86d00d204101f3d8336"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "90dedb1ba10a66b78ee1773225efa891e191950e50d8d67615026d122639a0ab"
    end
  end

  head do
    version "2.13.0-93.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-93.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "3db1ae2d290b7d63b594ef74b40fda2a9e1a756e8bdfa0a38809e8ddbd51761d"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-93.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "b58112b00949037f5594450ab68412756b7d43f163f0e156f7564dbecad3f7b8"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-93.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "b5da09aeaef4aec93fbd1b35c3ccd682806acda6e6dbba880d8f1fe6604b31eb"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-93.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "4475b21e636c07433d4498c8dea624eeb11f27686c34c78a249e95711e596969"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-93.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "1b93eed6885a4c9909d149dc321d9a351dc747304d6612637176efa3dde63be4"
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
