# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.5.0-278.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-278.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "6915ab17070b330e93de8d1ef7d52aae20284c38fffbcecf2a9201e82f79ce46"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-278.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "7ff44137fbb559b1328f18b32b8978111343faf959640e47de97a3a25172d614"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-278.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "f82cc50972de00ff58e1d308951d33cd6e816c8a3369b3a8670111fe19754863"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-278.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "7473793eca49fbfb3124e0a4ed0212e9496631adc8190b887f09f80434686e33"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-278.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "f3c5e2a6dbf1751ddc82d5a6efe637db74a23a6e258a12aa9c51b27c21dd806f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-278.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "a3db15a998aa2567f0e749f20b8aab2de4d4ec220b64823fa247b7c7e3e18e90"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "fda7beb096ef3a2311f4f11ab774146fc8352fc73f154132f7c76404a780f9c8"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.4/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "ca750214e3fe0f88c0fb07b22f523c53a307c184f2ed51c3d3dcd2cb9e7bc317"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "1968cc9ee12802317f9a2320165f6966cf949dc3574cac1cb91a1bc7f0de67db"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "a2ce567c7953c901af15e5ce89436d611f601bbc64f0f4a920700e9f1d61f902"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "b4cee491863d2ca6c324fad2d8fe2dfa123f78164630d7ca5eee45b940f70346"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "2ef98f20dd52440bc664d7f215ac888a40755878a0e96cd4356a8cbbf0c20b6e"
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
