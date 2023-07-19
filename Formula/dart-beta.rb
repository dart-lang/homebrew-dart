# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.1.0-262.2.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.1.0-262.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "517ff46ee4b5f295130bcc84cd501a03ff29c12b8527d6e395f10a873ee79d93"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.1.0-262.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "9c63ec4e74cf11871dc76462d6fd36145b82600c151ff20dc2ef340da7802cf2"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.1.0-262.2.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "b90ae62e96944cc68ec1f77d70b905ff0fb91d0e5efa61622cb1844e21332bba"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.1.0-262.2.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "98809e8e610fe968fe083bbe9c8a342b6fdd796a03a896bb2e52cf668e8e806d"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.1.0-262.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "758a39c314e32e3f7ed49bc295b1e45b2fb06383d26eb3f0f141d718d48cb5cd"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.1.0-262.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "38f38f7c5cf549a20a908c3e42de9095a02c9dd1587b7d33acfd9b31d34769e6"
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
