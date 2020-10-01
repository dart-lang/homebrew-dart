class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"

  version "2.10.0"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "328187a17fb020c6547b203fc4e3f4d4a6f1ddf10de8bd5f9e27f2d2957e98d8"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "0b32eb971eb375c47ffb3b6075971380ed45be89035d48ddf3c332be9caecc36"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "02737abc5962ea49c2725715f1d03d62b54e926b1b8f3e288490c90e16465daf"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "010b5cec6294300fa75f65c80f86c0cd3001bbfd1c5eb597987e0651ead34663"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "5e7160fb1ad0cd944c3f7ffc0d2948d1d65b54f24d55f3fb98676b2bec135c5f"
    end
  end

  head do
    version "2.11.0-180.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-180.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "db042a7b8f9e77cbbd62342017c0770c72743e88d815db3f696e873bd7fc67d4"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-180.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "c8793c43770aede5627043214820d3e07741880aacf1231155b059bff455fd28"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-180.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "4606374b4dc248ce3dab3960a90fe186ab948fd97a0c3b3e5d567fe816d3e686"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-180.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "cb5c4823c93dbf44e5a2376ae00f92f388e8710ff94c3b0aa06187f42962028c"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-180.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "c07778a14f0e5e51ff0bf04fda1ff05534285c5e72e6158196673486b8195bb3"
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
