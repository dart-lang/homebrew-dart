# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.8.0-246.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-246.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "22ddb35da95664dbf8e79bfb9d5ccca7b6c964008864109fa68491ac3b237756"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-246.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "b987c8156cde35605bf68f44950a7e1b8b8c0d6c3fde1648b4fe509a4da891fe"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-246.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "a838ffc1f435413f3ec7b2344715d13df9f588a3754b4d31790b1ec98bf0c009"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-246.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "21ae961efcf122a15312303a0e187ece03ce70fe6040349f6fa112c1bab82e00"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-246.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "bfb2792b26503d738091c449f4d0afd0c62fd313b6743d235ee128560d473973"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-246.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "bb1a864089d2abf5338c85c8d60088c3481d5b148fac601976bab48bbb72f5c7"
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
