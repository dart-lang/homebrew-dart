# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.8.0-205.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-205.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "d0165a385a503fc58ecf12d8eb8ce8569f4d39531bfef39f1276b2813b0b8046"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-205.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "9bb1a66cc5552e0bb15b53c353bab56efba855c502bc526b7366d23effc61ed5"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-205.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "a09419c8f55dffbcaa53cef7d1da0779e19eeba3d2bbb076026b0d0919ae9f5b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-205.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "f44c518b9448fe100529717202bc9df064a364ff73b4997088a5c6f0f5992180"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-205.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "63a2f00b0c67886859e527954cb4954ef0250b803aa5de7f9042d041f3c40576"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-205.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "65c84f916564e359de79f21159de7a8f39e3de5e255cbf4ff2c7310fe03b3679"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "060886d2b8ae832f89ce7db971eeb6218a507e37071152487dd52eb256a449ae"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "106e63d9590090993a95ee51e68729de2d09ca2b7b7bd16c0b5fb57a60b3657c"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "c216fdd70f656c50c78dc6a0ffae6e5ced7a9a7ccedea3e402fa6b5ebe24788c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "02d616ef67d8452008eb778fe13a6eb9ab03c805cfa9952a5b94a44b97a27a78"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "3452ccad61e057eb7fa17e85ed1aa035d44c36e33dac07655717798f47e64ca8"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "7376e09dbb66aa8af25423a67c36f0ccb771ee280f12ed8157f1e26095abe67e"
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
