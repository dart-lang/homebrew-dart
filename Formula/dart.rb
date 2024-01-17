# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.4.0-24.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-24.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "f3cd8065123c147a215cf69ac029eec5b6782ec8ea3d548f63c67da17f8dcf4e"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-24.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "bac5a5e6d974c3238259636bbc26abbb664871a591bb6c98bee8bb88b5017c24"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-24.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "6f43abe4c8ad3a82b4048c80fe71edff99aeb5497af4a13f66c31170db311ab6"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-24.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "26dc9e8bfca8fed8362ea2c1efb51bc5aa129fde8ab74394aab50853f7de7a96"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-24.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "69493b600f1338bd955b24446143a8c9426784d8ea2b779a3450d65034cbebfc"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-24.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "804a400df98cbe74264cbb61930c48adafbc7944c73285b471a50d2243f62479"
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
