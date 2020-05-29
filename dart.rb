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
    version "2.9.0-12.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-12.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "54d1505fa05aaacd4eeaacf28c235df7436947bceb0d631fd0f693554d9615d4"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-12.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "402c87ac764b07fe434ae8186b24492ecbe13c3973981f1df334fa18e8c1d711"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-12.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "1aa980d2c112012237409840e87e354653c65a578a3e134b7042effc827b0c5a"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-12.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "2474a50d13a43b810661e84a6af5b29a5ff88e9c43e312a9d74222fc48081b6a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-12.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "bb501ccd5e5ebb5f6c6fc31db4bc4c68c9f28a60363843ad090fccef410086a2"
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
