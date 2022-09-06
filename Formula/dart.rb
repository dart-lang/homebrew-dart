# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.19.0-164.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-164.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "210ea8cd30a012ab8ab20ad266fd8f8fc236a709741a66188c9ebace22d0b158"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-164.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "347426e0f85a70b6886df058c11c9c6975314964d13f0a1dceec97071f3e1be6"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-164.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "ba350bb0b0a595b232be9059e0979abf75deeb84aaf0f15f2bbf313afc56093e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-164.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "b7b027fd7cbbc28e9dd0c3884a63a989b2bae1bff42567f91b3392a58e7d18f2"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-164.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "f677d5088473c5e06c8dc2af8699e1a22d41e6801e4ef7d457bc27e651b457b7"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-164.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "873e5e4923a1e859afe5ebd979d3b4b69fc047244cc2e70e29161fc6ebe05ba1"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "cf2bbaafc6a421dfc01e904a1fde702575eed4b0fd08a4a159829fa699d2471e"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "c1f521eab5f2f23002d135502735e1e12ad5d8342cf52bd8f0f1ad360671f9c0"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "e391c4ed8f623b9748f897cb585d629057c1141f9eaf8e9b2be118932ba11632"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "22448959f028713d65f05da2800911f98e4f3580f93d9d23db50fc68993d2426"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "06dd7c6eb6c903f5df8b23f9a35f7b1c35ccb869be6b5019c7dd93868ae2bfbf"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "2e83b4a03a9210713a2c65d2c50bd680984c414c3c89d78baba5a20f378fac7d"
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
