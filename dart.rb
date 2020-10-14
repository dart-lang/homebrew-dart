class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"

  version "2.10.1"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "f2dc5d040e908183b3797c68e03cadf7fc1f4f23092651b2b39f7bdb38e4c37c"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "3795860f2d27b0aebad25e5a9191c2534ecbe613133572f565201d50072da4db"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "bb7b7743d89b2c518147d67f16dda135bebf02f289acefd27c3e97ad0e828a27"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "6b4e8a05283cc88f0607eb0e89f21494a5e5ee42d598860119e52b8ef5a207cd"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "f341167b34fdfd55751601e7ebc2dd1e9db3aa8a74bf765d6090f92878cd1ef7"
    end
  end

  head do
    version "2.11.0-213.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-213.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "99959a2c823e9523bef7a9811753b738e1e09cc5a8e39ae4a7e12c23a35e0aef"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-213.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "491dcc96b69fdfae3cd38869d16b7c26f4960d0ca48f9e19dffdb44000de852e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-213.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "1c86768b6cdb5b67ebb0147dbb435c6f416513fd899be472a7fa2b39ed1f6b25"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-213.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "ad0f0893a2115dcce03987ee969320c1a52dd785ce725aa466d9012ae96e6572"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-213.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "5164f1865cf572ecc30ea253cf3dd1aebbc134693f1e82b1f3198764d7ac3447"
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
