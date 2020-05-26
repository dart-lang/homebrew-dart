class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"

  version "2.8.2"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "3419da592880749d1a7a9e186998d8f1abd338f0daa1a2d39daaea7406231c00"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "eea8ad884e57571aeb3aac57aa0e98cd1eaa72fd4ac5408389fe2541c4f990bb"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "0259e4829fc434a3f3b9f9b693ff29e81ecded7e0be8f2831cd0c196b595665f"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "e5dfe9e49d6d03b494ed8fbbde839dc8e9115ab152742299d37bd0bd538bcd35"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "ae8c807e6d6351773686059f5b563f4aacdedfe7bc55a4263df1d14f852d27ff"
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
