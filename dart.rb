class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"

  version "2.10.5"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.5/sdk/dartsdk-macos-x64-release.zip"
    sha256 "31a507a0baad581704fefee2d37ad7c028970c4e56799d5a0c206dc38ba862ed"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.5/sdk/dartsdk-linux-x64-release.zip"
      sha256 "5037a2c0fd631afc1e77e8ef86fe1ab60420d810cab67ac86f4179d9f7a866d5"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.5/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "c7319de95d1e9c471d8dbe80ebdabc0c437e5ec21c7814c96b79a9ba79c6e481"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.5/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "c5cf15f6cd6d2ed5212a0545936d59398a8366878e90a022675c9b443c1f484b"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.5/sdk/dartsdk-linux-arm-release.zip"
      sha256 "12db2a878a450586da9cba8f22adaec23ae2d7c8b4838a2be58687c28d5b6814"
    end
  end

  head do
    version "2.13.0-59.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-59.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "8afe06e99fe5dd060b99324eb805e0499c947f59986d1202bae6527dd363bc3f"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-59.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "8670c1c4401ccd0249968b92f6ab54b657ca38dcc4d88f223733cd89cb66e710"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-59.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "56885e4f5a8e8caed1453796a56d5ca972a358573e06514ca9172f2693e704d6"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-59.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "6a0a6fb3316cbd5c70a9d27e0db40eb95fa7db1ec1bbe3d8e0906949f237d852"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-59.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "d8868ca9c507073aa34f8b9cadf7dc3ed30cc665c90494e4a762f6e84a166af5"
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
