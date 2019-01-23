class Dart < Formula
  desc "The Dart SDK"
  homepage "https://www.dartlang.org/"

  version "2.1.0"
  if Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.1.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "5576013b2d5e03f3d8cb85a6cd8820fec2c9a856c1510c0666ff2157065aa76a"
  else
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.1.0/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "946353103266e0b7b87f5e89065c0284b8ba01ab67d571ae2fbc568528773285"
  end

  devel do
    version "2.1.1-dev.2.0"
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.1.1-dev.2.0/sdk/dartsdk-macos-x64-release.zip"
      sha256 "e198d1187cb5693510bbdf4b1d40979e5e5d1acd2fa9411f6d333fde87ad256c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.1.1-dev.2.0/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "4e07c46173afb60d0cf3672dc5055fa4285889ee255a19ddfa3c9c6e3dbbd740"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"]
  end

  def shim_script(target)
    <<~EOS
      #!/usr/bin/env bash
      exec "#{prefix}/#{target}" "$@"
    EOS
  end

  def caveats; <<~EOS
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
