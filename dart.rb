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
    version "2.11.0-161.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-161.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "52b6351e4abba57a61623b3b985598107861287f146fc266774ace29cfed9c56"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-161.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "51849ccc3710c6597ca52606063b9514cb5426cef3965bb017d03bc1c977b115"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-161.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "8bced49f7c631c49a0e702f20d3e04afb13183bb0a75ff35923cf7b166de35dd"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-161.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "8847b967ad86b075b7d1229a7826f0ec7464877fce1d61ddbae025e5050245bc"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-161.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "45e02bf8929518c4f77681aba16d3121ddcf33ff201701afa52b2156c551f0dd"
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
