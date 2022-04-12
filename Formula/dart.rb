# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.18.0-9.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-9.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "11f40010b27e335b94f8a0101c3f10b8bddc9e0383d57660dc315dc1890680f6"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-9.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "041a6f083df4f73379d1d7a13cf761dfd1e229d01d9fbd8bbc8e8174093add62"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-9.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "47d9c1df4b059404d4a75aee605ce19113bd47542232d2c50f995ab8e380769e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-9.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "cfafc67d0ee875609659766be203344667b6501029ac935ba3beb8ba0c4dc265"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-9.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "6f2118a904d92c8b5c4777eff836bb32aaa4b8b2d4170e498dfee449c8ab885d"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-9.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "b1c61c03fe1e66acf6a26b991843a79ab6561f814f9d7789c4b51fba8e3a08fc"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.16.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "018bc1a063dccd5a1f7c86bf06ce4660aad6a7dc441c10d8271eab1afa48746d"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.16.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "7994346806962c2ad2a124f4b2cb976a0260c33f2df2599ddcdc576b9aa3a20e"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.16.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "7a0ad877b0785e19018873c8144db3a29c4ab50e7c1aa968800280fd47a25e72"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.16.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "069e554c30a9e5023a00a4bb2ff5eb2ad9d3509c3e6363ea39db2e4d00465ca2"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.16.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "be67ab8d79140149c8f058cafbadaa2ea8044e603e04b3c4657171c18a48f8a6"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.16.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "6eb58d7721bb27827d2bbb0830f3479c0e1d4c257b1c4c802ab8811c7938b02f"
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
