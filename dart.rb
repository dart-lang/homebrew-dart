class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"

  version "2.9.3"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.9.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "f29ff9955b024bcf2aa6ffed6f8f66dc37a95be594496c9a2d695e67ac34b7ac"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.9.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "6719026f526f3171274dc9d8322c33fd9ec22e659e8dd833c587038211b83b04"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.9.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "82116dbc7e16ca4bd04c090be2bb6014bce8d0a71823a1ffdc5842b658b6132c"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.9.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "2be9ba987e0d0cfd89f8eb803176a7342679d892f4ea2508de7fed03e25cd93a"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.9.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "fe5e180c901b4a6bf802211bf7b4918d321c3924f55088339f7fe3a01a8cc735"
    end
  end

  head do
    version "2.11.0-176.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-176.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "afa4ac80f5f7fe1ebfda2559f7c4c12f3db66580cabb202b1bae8d71ccd27adc"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-176.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "b5b22a7a184f90e57231a6479e950bb7f3a9df39812ff370aae5ffcc3111c9c5"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-176.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "800401b332398ed304137af974b5e69ad9494d6ca4b8b0e49a768082c21443be"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-176.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "b409b0663985cdaa119bb1edfafdd5cf8318ea0047429ebf4a7389250243f6c1"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-176.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "53973d772b657baade61def5b7e4acade07a3c153b462b35bcf817108ecff016"
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
