class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"

  version "2.10.3"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "ab1375fecf79ef592c6eedb6910e01c6b076ce5a5077f487d1cc665432b8ca36"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "315e0835407bad010e966b5f92554f0c6efdc4509109fdf8a7644ce3bcbf09ca"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "3e7d9d1bd9b40f480cc6dbb08ee5ed6ef36a44ad88d77696a7a67b8cd856b7e0"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "b0c5e16c874e20b64752972959b3868a86b1d480ba16595091a76ac3da66d91e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "221771f37eb2296383eb97460c7dee11ddc57626cbe2ac790310f06f1c572e6c"
    end
  end

  head do
    version "2.11.0-240.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-240.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "251c5bbee39f05d7ba5b742731b39c99ae80148376b854e938491b9073b05fdb"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-240.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "777a822012737110066a4395e3196936d67c23671e958c008ac5af491308c735"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-240.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "3dd1b2e2a0cfac8ef92066c826b309d8f0913f0a5660dd5a1e10f6119f7a8cd4"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-240.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "336b7e06ba3ed19e50fb8d0ac3ec199d0f4ff629382d34bdc1805aea64835178"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-240.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "64d136120f9d46cf73b7ea929e264a9bfad722e2cddcf824e7e9423afc2e2d87"
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
