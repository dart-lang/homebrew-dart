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
    version "2.10.0-110.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-110.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "f9ee3241424aca8d76f366997dcabb8db889586e660940e84249bbb669794cb7"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-110.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "84e9e5f9487692a404f14bd07ea3049840c5d6c05672848ec1134d96ec4e12f5"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-110.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "22644119de164a70975cf193805a61d9182407ce527afc6e01642381aa783fc2"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-110.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "7b0ad4c5b762cb6b7dc6e4204fffcf3524d8a78c5990879dd5ec24f29403f424"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-110.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "bc6e0b6677d6d024390a6a2abc57cd71620522a0736d0f2c8af84270ddd263d7"
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
