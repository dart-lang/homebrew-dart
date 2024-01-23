# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.4.0-47.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-47.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "64884240b6bb9db55d6507193bd7d8b3f7c29eae9ff6573f3055bd7a95943ad6"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-47.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "dbdce7d4f85d279a143180714f1025d95f582adea471023aa7db610a8a10e4af"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-47.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "fef4b5d0d83e9b91bb7e0132c6cde87ca52739a945f427cd718fc3b1d06aa04f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-47.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "bcef73c861cb0bafae919f1c84dc146268419a9ecc096997cd0da3421608085a"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-47.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "cf9d69eb1a119de0c10ce782232e629ae479e88c0a445cf977261a8a6f7c8bee"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-47.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "30d4c4b038e62b5ecab873f274d3e83fc993b6449fdaa770a380f45393017835"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.5/sdk/dartsdk-macos-x64-release.zip"
    sha256 "ec4891331e3424418ea56976f262a408e8d7655b2917dcb5844557a7c971d349"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.5/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "a218f96080403e261c5986ce0ed4c4ee3f9d872b800f34540c2a8526cbea6b52"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.5/sdk/dartsdk-linux-x64-release.zip"
      sha256 "e35e66f6cb5f511eb909fc27f9cebe81712925b6abd4494310003cdf26410ab1"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.5/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "42dfeb6b00f01cf449c9fceccbb4805d50ebaa5129164d897e4c465ef7223f60"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.5/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "aa840a615e90fc26ca0ca348be8359b254a144cff6a0e2c3f7eb361ed9aef393"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.5/sdk/dartsdk-linux-arm-release.zip"
      sha256 "9b08a544e8e6438c136fcef04348e0b796ee4125eab291b2657b56b3df60e8dc"
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
