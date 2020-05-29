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
    version "2.9.0-11.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-11.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "9dc4396a4d479bf7b5fe41147d35b3ff411b70b90254fab956b43b031b312820"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-11.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "31ff42c547932f8f19364b59b42bca57879dd96b4f25adf3b060d41f9688081d"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-11.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "9276a68098917d8bb8b79cc769fe1e495eefb536851110e1cd1271c4385032c4"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-11.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "94ab8185f354c9ad30812c0dcc4c1d9ae8320b1e9c2222f6ae9ed7ec9f8f898c"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-11.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "260718e03a19bb84531e5e36ba60744b21a636b4abacb4d156b4f1fc502712ff"
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
