# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.5.0-196.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-196.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "7c9185f8593eb044a85829b32d95432e02f1f56c95d68e0e5b5beabdd8b0403c"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-196.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "2166c2b3b389f630c0e77db277e8cb238cd3f056701a781094d82c1b4061bbbe"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-196.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "4a4fe21fa7c2ac239462660576d06ad2c0e1ed1e90473eb465868594b1f6bcf7"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-196.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "7cf89e504c00e091880cf3f941f7fc5b9188082de243283851edb686897bdfb3"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-196.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "499da256a4cb904e204afa3f23494afd390f2d6273f6fe4357774df0ec25e507"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-196.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "fcc8ec15dbd4462b4937db5b47e323da1c339ddf161c6a4d2a5a5d78fff220cd"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "c6748621035b13994c3e77073a2cf9d9eb007e8d0b93a1f6329b7870cb5e2798"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "02ac6e6269da03f9d99d01376c3186d95876e72da98d265bb8d541a31db9a575"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "d1078d3dc8d69b58b0e9b84e639288206631ae7bf88b13629788e8962029d142"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "1be254b42d3ad123219e7bdf84d819ae43e863286bb55b4f48cea4d630319bb4"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "84bc75b0ec3eb5b18690bde364a5a144ccf110f4599c4a2a7d2747d08d9383a8"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "e04cfe81672dcc126640669f6fc881ba154028e3f2ee22b57b13d0cb54007b9e"
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
