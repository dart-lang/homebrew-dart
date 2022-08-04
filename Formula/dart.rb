# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.19.0-59.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-59.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "8d035e4676125af7542bb812d08a74388aafdeb6face32b7a7d22e34ccdc8431"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-59.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "388d2546108ea5d6e849f29831a5d2e529c26d6704f2f95f70563d7a2d7e8acf"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-59.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "9a2efd846d028a59a914a72381b8ae7e34f34f93753de385f5aa465ffbcd8f0c"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-59.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "70a0c71483e76ae71a1c145b71baafeb27acfce1ded1f737bf6f8c55b7a85716"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-59.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "f240a4776c0ba86d3e8fd9cdb88d6a5bdfdbb2d32df7a5d8dec17a4a386d3aca"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-59.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "916901bf1d69225de52ea02e2c6c1e6b8001f29c22dec87d6993e088a92bcd7e"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.6/sdk/dartsdk-macos-x64-release.zip"
    sha256 "9b1881c4167bba76c6ac0f92bbdb777a9d2b89c62977a7e95c37e028ecb9fa62"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.6/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "9c655ab17e1239dcd3ba56d8a9483ee298dc92eea305a46a10b2fccfc7e441f2"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.6/sdk/dartsdk-linux-x64-release.zip"
      sha256 "f837f385603a1cfb14ddb7dd0cd64820b297646626bdb689ccfc3278fa83b2b1"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.6/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "339133593726375213fca6156288fbdcb4c0644d725f8531910449edca2315fa"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.6/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "8e71b0c958a587c83ecd6c8cc637bc624bb85bc64e877e9ea00831a659a904b1"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.6/sdk/dartsdk-linux-arm-release.zip"
      sha256 "3eae7ed5773c125165d123a235bac9956981cfdf164059806ed69a6feefc1eda"
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
