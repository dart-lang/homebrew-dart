# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.14.0-341.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-341.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "b144d7df3c8f98b410d70dfdac91dac873391bc7ec0f67bc3cc5c3404f1249a2"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-341.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "4b602fee759c33acbe8e9efe8e18a2495926c2d476eda105800e7e59987a0ed4"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-341.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "3226822190fe4187866467aeb72708ea424c82f4e31b37f6647da3417e8fc80a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-341.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "ff111036998ed1ba350f012f27677c1534a9b6d9b168962cdefa790cdb39350c"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-341.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "b666d9ed949a7dea9ae36d454f2834d60165066f43916528cb0f0110b8ef5607"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-341.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "744415ce7317b09e8d6b66afcc43dbe3f7cef9f9019d5a6f7ef581f74d268bf2"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "934e3951d399aa654f45851dfdf6614acc34a20aafd8631075194c02d58e0e4b"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "633a9aa4812b725ff587e2bbf16cd5839224cfe05dcd536e1a74804e80fdb4cd"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "3116ac10532ec954d0dd31b99cb562279109909ba818dbe081b1c2059a8f50b8"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "4c6c2dad0cf2f61e5512660937d99c0c5c9d1a51e8f0ae3cea1307092c9cafb1"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "f7733f30e44345237a817bf9104fee1e20820a5796162770b964adcaf705711d"
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
