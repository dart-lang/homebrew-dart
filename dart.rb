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
    version "2.11.0-266.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-266.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "51a8df9f303126ae7540f22481f9ec23852a61f694116ca9c15916e20a7e7034"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-266.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "acd0bee100087cb2a21ffaec578c1dc617cc675ecd324a829b3078db5b70be20"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-266.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "b6a445adffdbc4e6ca70ed6dcddc82c050108739dcf5b98588c969dff9647e33"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-266.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "a8469f1ae7d04610bedf5d17eab48b978173fc7169f884ffe49f7b978bc384c6"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-266.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "cc9e3547c2d402b3e959b568bb5e134eba81d5b39b1c93286e9ca82c7aeff141"
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
