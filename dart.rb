class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"

  version "2.8.3"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "c47e127850c63b69974f8ef41fca262bf55a29f42f9190f58e7fcbf79bf2bb75"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "c84db7d64204770ff7b7962fa1dceee05fea52f179c8db837c3a7b72cbfb7869"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "8a75816eee1347cf17f76099b5290576256ba4fb92c9e596fb48239d5a488a79"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "11f9fef006ba766f97de695f3b3e07b1d2f1f80838bf4aa1bea0c775365d7d49"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "f5f98e347ea73334d8e9e0cda40afa6f02978318c017f2b7dcecda9d0f2609bf"
    end
  end

  devel do
    version "2.9.0-13.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-13.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "0467ffeb06503f794e5d55a7bfdb52c831e483d03ba41758c16eccda5f2a0289"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-13.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "903469b4fd690f887fc3d9030fe3b03591dace256981c45335d924da558f4605"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-13.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "e3db9717543a02e4062c62c59f80d7eeaa05662384f06312c52ae2408e520017"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-13.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "bcea66fd8eb774cc9e28b47acb9c49003923b23cd58a7c1e274a7b4687f357f4"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-13.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "bd047f01ed5d59eda8c25a0d3965e91153e5a6fe8647779a595bc1fc1ca98c86"
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
