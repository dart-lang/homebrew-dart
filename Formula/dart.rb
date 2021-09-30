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
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "388a9ccaf548033dd6472b3de895f96a625902139f751d2559de8098d27f4447"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "4e7af53c77bf862a16c3b9291583f7a3ec08f87c8adaff2553b7c3d02bdf8844"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "cad36ec238af96c8048bbcec4cff7e69fcb1b895620010ca1762674ca4ade171"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "b7c817e416b76f6ab1fd2db47fa3e88f15edf9e1e91dc395b2a00e03e998d23e"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "a6ede5f0d93ab53b619871c31c274d1fb63c23be1661690bf25402359cb5fac8"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "211613701a128193d4b3596be910a887e0d7f54c9221620badd5d277b34287a7"
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
