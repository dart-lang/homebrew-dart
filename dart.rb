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
    version "2.12.0-0.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-0.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "6b84b66af31329516ce053dec81f2ed65d0b4b3395dc21b369544cdf56522a9f"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-0.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "cfc49ed72f5c9324f0b94b5370c907ef6f0fd9b39977cfdebf3a72415257cd8a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-0.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "0e8c5f3d1b47e078783a8b14faab28742cf74f9f8ab14eacff4592274d3a477f"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-0.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "3176814f796c42838a953d285ef793b049617f4b4795e09b9e5c60cc40146cf3"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-0.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "177608afa698a46bfccd17aa219c12db3177f555adede916000e7f2f41adf38d"
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
