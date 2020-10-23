class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.11.0-213.4.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.11.0-213.4.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "144662e3ce4d96172c527855288b5b54319e64114bd67744f9ffaea90af7a0d6"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.11.0-213.4.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "ed095f5bede0c50a7f87bac236dc853557e9fab080e8e0091104f7ddc9f148b5"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.11.0-213.4.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "81b7d99802c3cb4d0ff5cae9bf15eeea579bfd176f57238a9a1ed3e8ccb28fd0"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.11.0-213.4.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "0a0076eb5ab5621ab40579c33869fa4a75e01d3268c65cfc6c06cdaced72c447"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.11.0-213.4.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "8e7b1a4435529797ccce1d90d8516f7c447b09631609bd01ff8674b4ea2bf9e3"
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
