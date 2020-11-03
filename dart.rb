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
    version "2.12.0-13.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-13.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "a4cd33a2fd5630ad548d3941c5dcddced2b24e71833e051ddf20eb2d396dafd7"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-13.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "cd10d386a669cb99cb1769bbedb1c0ac34b772f570bb82c8dcb4101782a46497"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-13.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "caae0bcbe34460a57bf02a4d9eebcad360467e4053bc4b191b41d877481c3a24"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-13.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "2720c8af3611513044450436e2a00c4e195e1b4ac154cf00924b9c852f449e92"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-13.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "4b2bccfffdec880423571e228c331808a85c33357e781b4608c91361e6171f2e"
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
