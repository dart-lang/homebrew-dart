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
    version "2.12.0-29.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-29.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "cf48286128d2c071a2d45c220de32a2ea037f8db222a90a639f32a0b98f5fc1c"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-29.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "54f2cc5c7dfea8f80bc88281293076eac3716cba94cadc8cfa5cecf94a24ccc6"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-29.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "a9432b605cd7d883beb218d87c51091af4e26e9dff7b176ca6d5c43292b606f5"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-29.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "08ea83935ebe08a809064ccd01e6ae579729351d033dc49f25a78e45edc6ed5a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-29.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "f9a747f6875f35bccae2151d38caa8b336d0f2df4990db4a2a7c9e0b3c7f9901"
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
