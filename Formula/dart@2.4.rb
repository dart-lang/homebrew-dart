# typed: false
# frozen_string_literal: true

class DartAT24 < Formula
  desc "Dart SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.4.1/sdk/dartsdk-macos-x64-release.zip"
      sha256 "62006127bd3acd1b7eb2e4fc7baed061eb19b80c4ba4af481db5244a081fff3e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.4.1/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "3591578902f3b3ee155aa90bf893f3d0b50fd12567454a8f980440fa8dd1ff23"
    end
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.4.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "2b9f7c1f4ecd9b1e2a2f770f84e44646c930adecc5f96e273d5b26c3f924a003"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.4.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "ff1f044055410f229f3ed7afe1617f92c06e400c19245c37dc1ed8e6c9e33b48"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.4.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "e53e1f2b84173c52b5286467bec348e1d796052d1e483733802eed704fd16612"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.4.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "9e9b9ddf669cccc0253417b4727d5459f74bab7127423fdcdb9a69132224bcb9"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"].select { |f| File.executable?(f) }
  end

  def shim_script(target)
    <<~EOS
      #!/usr/bin/env bash
      exec "#{prefix}/#{target}" "$@"
    EOS
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
