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
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "07136127f4f1fc8ff54ab3d69df53535bed14027d56982c0db4af394ed8d0c25"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.4/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "612118e856e6eedbdbea4c8d9e6cd1fa73a21614db7ed2e66dd991901004a103"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "f8591944512834ba19b4d8383d270d7f56fef03c56ba53d4e35c23db80ea8a33"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "6ee9b912ccb6922e5a9cf1d8687398aa7e2ba283c327e55a42c95c8859892e9e"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "c81303feea24228148bd4ec14c65bb9c341cba3596e3d68e8a874a9df947f928"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "a87833fbfed26ef810cb135c47eb7b5bc24c906b55abb4a2e183fea2d3ce1b51"
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
