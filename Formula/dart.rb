# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.0.0-277.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-277.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "01184d443f42ded720c8abd9830f4ff340b6c91b7fcd5cd1c85018fa369502bb"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-277.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "7bfbeb800d4cfaa990ded9dd42ac1a16157d98f12dae5ef3868b98a059ab1c1d"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-277.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "f2ed05b9c72172fa1c562f054fb1f4dd3fd1dfce7e0b4d92879c62656bfb96ee"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-277.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "3b8497a8eb60c3da9bce26396fa3aea9f998fb352bb5b10139b555f3838d438c"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-277.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "b8fbdbdf2a1de3a3ee5eb608b930d200c45d623d0ea2f0431477a0ec0f1bc501"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-277.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "8ccd773e8deedf3efee535ff8af9a327779adc677c428f4536fdb9a090824337"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "9b44776fada33221228ce86ea4cb03a809bb9e16fff78eff429aaf234d7170a4"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "dc2e0f7b8b15602cedbfaed01180628f40b2c14500af2db891816ae626a2602c"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "93b5db66868b0a0fd7f3615f2ae279985430de57f5e925e498d35b7d79ab0747"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "0011b8070a5a78c560ce5e362508cc0859935ea3af3fe6b7fccb3847828e7a76"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "af6e4aa9a146aab0844bca502c3bb3ebad33895d78f48743ff3513a7ef3dd163"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "7f0d6dc9d79dc5168ce3000389b91039b1273104546eee6104d1e428e12fe72c"
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
