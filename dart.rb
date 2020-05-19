class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"

  version "2.8.2"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "3419da592880749d1a7a9e186998d8f1abd338f0daa1a2d39daaea7406231c00"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "eea8ad884e57571aeb3aac57aa0e98cd1eaa72fd4ac5408389fe2541c4f990bb"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "0259e4829fc434a3f3b9f9b693ff29e81ecded7e0be8f2831cd0c196b595665f"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "e5dfe9e49d6d03b494ed8fbbde839dc8e9115ab152742299d37bd0bd538bcd35"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "ae8c807e6d6351773686059f5b563f4aacdedfe7bc55a4263df1d14f852d27ff"
    end
  end

  devel do
    version "2.9.0-10.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-10.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "4878db3c7f55f485969c324fd1a8aee6b7d901621c70e568c7a20dcceaa25d47"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-10.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "8216005784529447b40fe1c59f7970f456a3d9e1cea8386af1a32ee8b3f11c7d"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-10.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "8d93c060e6a7d5c1862ff29843094fc7280406b895dc894ea2dd24533722d2be"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-10.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "9ccaff316edd09aa31a393a4bb98b231d7eda0ca60519f957588bdcb17cc764e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-10.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "99ef59f83b7a8bbdbe39a6c6f973044f9f565ac452a4b24222d90a337372feb7"
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
