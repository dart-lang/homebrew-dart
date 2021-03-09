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
    version "2.13.0-114.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-114.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "498064d913fd4440ec96433a4f2db789db58f3a6135eaa92540e5ba1de3e092e"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-114.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "f5cd4b6645ae9ea942828698938ba919e20bf703e692bae1726135634dea8ecd"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-114.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "602f55cfb342eb333087fd34a0484755567983a0be3a1fd6b2ba5728409f103b"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-114.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "30fb97c7ae0bb5c89527432645fc461527afaf6a08324d61053aa41f1b631e79"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-114.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "db735931b43275c8f9109fe6947949577015e2110a4cd6190ee9f98c1ab6a3e4"
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
