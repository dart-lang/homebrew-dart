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
    version "2.11.0-190.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-190.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "aeaf2f5020bed7d5e94753a59d2e9db0bc017c2819a7c2b7792b621cf2eca643"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-190.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "a618cc8044a749fbc38f6534a8eaa6edee0bd88496069f58407330887e7ec2d2"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-190.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "821262edfb1d58ebd0485701208f1d957f688b5362e7458618ed53730536de67"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-190.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "6464c191c1c47b197c069e4c9b4872afccdd75cfef47eb865f1ecc9b85e8af70"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-190.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "79c8cfefb6fcbbc7629e07b69328ed0c01d0620014220af3e92760f71dfcb040"
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
