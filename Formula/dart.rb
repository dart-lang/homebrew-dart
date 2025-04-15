# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.9.0-14.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-14.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "13e9ada28887dbfd7eb80c8175a49924866b578444d47414d5a71cf3bf95d942"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-14.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "bd9068fb216bfe70c08b326e7e28251da9d31d12ae9749d39ce9dea05bfcd05d"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-14.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "cece83819ca48bff04f142ce26e43a2f868b5e2107e4f076ab6969d5c5fc5760"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-14.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "dfffabd4020142a9094f181bced1674a5ad16d06510d2f87835292adf2abf999"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-14.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "da7895d6c94beb0f60e51ac36fed604690c4c999507184b11fb4944d809a1ae4"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-14.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "a3bb0961f1063246ac537eab0d637cbc78f4d269be001680ef81b92b08a2d7cf"
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
