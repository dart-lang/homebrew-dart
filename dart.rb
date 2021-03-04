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
    version "2.13.0-97.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-97.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "acb9743ffb30fa833b6cd26c1b82cfee17625706942d10b469296c40e4c9685c"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-97.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "b86fa97c2886d9131421d7a5de1a37fbe141012fb29d2f5a9f19b244eedaae77"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-97.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "a481929138a6eb7bb1f6aba4162f0c8fa17295ebdb81d83a3b8cf8f523c45cd6"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-97.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "9c927d9add4a75bf32976902d41dcf26ceb01369b2cbb6205fe3fc3285013159"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-97.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "0149a8666a94b9d0a2ff4cafe3d6b462af126b015f0499a42c684a4b957f3f38"
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
