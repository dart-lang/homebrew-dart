# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.18.0-250.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-250.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "7bc855565725ff27103e638082cde197b4367dcc8932bee230398aaa6f02c8fb"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-250.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "80c694b9dd815a381d282f59b2a43a649e67fb77ee97ddcf581b07ccd4781633"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-250.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "62cfa9e4d27e231e3930c637d987b14ea793120ff0accfe6cd139cf7388c1eda"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-250.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "972cb02da59b9e272e129833a85680d0d701c64bb8706843a2a7fe4ae722a03c"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-250.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "d81fae42f548e553e518215f889b82e79ad12a419cf473f268b63c8f14303146"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-250.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "a577be0876be1e209579d4c510a2784cf32dc8144bd655061710748f2e0f8d96"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.5/sdk/dartsdk-macos-x64-release.zip"
    sha256 "55e2ffe2ddbcef88e7a7fcb87348ff10934234f0ecbd9b463316018e8bb7d8a8"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.5/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "ca0c0df7085465a616b86919fa66440632aedfd7a26cda16f3412421f8e6ee96"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.5/sdk/dartsdk-linux-x64-release.zip"
      sha256 "0052467a23ec8d46523be0f29263881444e0da3228860eb6b69de0859aca2459"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.5/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "26dd57fd191638196374bc77059a988b5510d7cb169d3032a2bde47ccc4f1957"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.5/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "0482ba914c7e9befc67d1ff0057bfcae354d6cfeb0d4716f1ff44623089a2688"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.5/sdk/dartsdk-linux-arm-release.zip"
      sha256 "00e855429cd7345a56235a7b216967d23c22d0c1a0417249c4323b1cbfe9af62"
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
