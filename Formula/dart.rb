# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.2.0-180.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-180.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "04dfa442138a45cfd037eaf8c39720be343b3d61f0fb2bda16c6f2014e60f2a0"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-180.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "b346c892157619aaaeeeb13dd572c29ba069ddf1490f6d8c6315c67b4c1bacc6"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-180.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "674075cf4eca7b7de5e222969fcc2cc24a7bccf150ec7c081e3c047833347bea"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-180.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "a6ce98f97a9d94c179d490ffb217223c17352ed1499f4178f505e14c36af80a6"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-180.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "5ae81e106f492db08349d97ce68abbe240dc8e2da08084673d83b1653dac0aed"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-180.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "c47a276cb84a80901bca28a51fa1d7f65ef8d01c1201299c1ae9a988b5a7b16c"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "b3ea3cedd598cf3133e8652721a06b4d7457d2b50be423d57aeb00c3ba3d778e"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "d31c3cfeef372169c4b709cd18b1c6bc484683fde94cd9c96c54d1e53cae2316"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "be679ccef3a0b28f19e296dd5b6374ac60dd0deb06d4d663da9905190489d48b"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "5c5d85df84f289a51eeed147d38e16a77dc33c445fc53ed3ef5e5700b981194a"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "395180693ccc758e4e830d3b13c4879e6e96b6869763a56e91721bf9d4228250"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "0be45ee5992be715cf57970f8b37f5be26d3be30202c420ce1606e10147223f0"
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
