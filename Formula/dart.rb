# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.15.0-168.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-168.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "a1cb46afa2f4940a7799be9621b684d98f7b54b37b634e793936165a15d1d63a"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-168.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "1ae630163e143ffa5235252e5535d2e76af666a8e1fa7fc13f19575d28ab98c7"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-168.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "05cadd7d66e92e0762b41118019bbcdbdb4ec593b226303c13f69f28e41b6575"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-168.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "152ab4e345a97639792f0194aa5fe5627524eaf9546a0181fb098dad1b5d0f35"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-168.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "aafd1dbf1d018d8f649d6411fd613e36d1c4a4df8eee093561e4fc99253e0c9c"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-168.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "1e40800a67b71c042355595421a7c7bee41c2241ecf69ea994a36d51f3b301cf"
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
