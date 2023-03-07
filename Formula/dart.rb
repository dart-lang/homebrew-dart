# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.0.0-290.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-290.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "b24dda8d0cd618e197263d77d6b9b8c4e500053d0e1ab889994d1660c36c753a"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-290.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "686a4bf4b8bdc2a4c8b93af669d6f4cf446de080e6005d5f3ec951dc1d6354f8"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-290.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "b5ba91b9d0daba4ef36075eec340764a5764257e72dbba5c3a8f7407787d6ae1"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-290.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "a9c0c776dedcd1f377734b14f9c2e1be6e0afb43805b06dbce2dca4d734b8d54"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-290.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "bb15136e76391846487293a01ff68cd81a7a915aa765d9d8e53c28a1cccbb1bc"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-290.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "bba22c8441ee41c1580d03dca863d789263b3d46d8f287e9f07be2e44a360a8c"
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
