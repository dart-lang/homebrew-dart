# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.15.0-178.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-178.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "e15d97c37f851e2d4aab70b373c16c04c0b86c333d430c3d5b5e6897bc043f21"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-178.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "a4ef11b9da3c6d13067b56f3b93116e4e0fc4bd0a31d7cf4de70ec4e325b6442"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-178.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "c28407db165291909aa2a77ef5d40a2472b3874f466e82297dcd1775d7f0e1db"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-178.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "a28bad09e88612b56325743b1faae99e2ee274acd9625c33f406abd9623290d1"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-178.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "e4fc6af92b30520994a18d1ada659f067d435bc72125145d6eb033b473e3b926"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-178.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "2ee9c13d9f8dc3e4e759ba9ee47374d4807f1ac37f6fda02ca49ecf56d6aaa46"
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
