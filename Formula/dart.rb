# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.15.0-150.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-150.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "d7a256aa09629ad4634bcae4484cd9192ae545cf692fdc9c8fcab4e977d4047c"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-150.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "1d4089ca79c2ebcb35677bd5a0d18fb20badf2663a5fe0684b350fde73311196"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-150.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "595e25bd0ba55ef377e6d3a9cf46cd334695fd70d035cfd77c427ab6cc4d2903"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-150.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "7b503388ad4d8f69357221da1a8e911a34dbcc229519be745f9d758ec7cbc1ab"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-150.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "f36bfe2dbff6562aeb1fd052778fc49cc81f47a4b740543108cecdceba71ec85"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-150.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "c0acc8d8d3d2ddb7e6d56caa2b3f3e36dad0f035b137452f8eb540e0e0998048"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "d0c24bcbda37950ae37e4e7e7cdf93f098cfea8ada39fd7ee6e06c7d97ced704"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "c9e7ec9be908b2f8352730d9475853d008176fc9c00b3484a65033c739c36c61"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "bd352ab4df3de74f837dcc95f86917d925d71793c4b26c2650e0cf814c6e22bf"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "302cba4dea5f772caca6c61be78657a1122a427908d4db04c960b4f004ddb5ad"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "e1e5514fc31457b5743781d72054398492d19a37163ace2ac3913b82017f4acc"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "09f57f277608e52086bd290775ea5991c6eefdbe54e6dc491550fd9ddb7c72f2"
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
