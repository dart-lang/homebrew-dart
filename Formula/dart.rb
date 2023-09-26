# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.2.0-191.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-191.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "e6b9ece955b8bf958d84802762877e5473911538dc1565d8e45079124494bf73"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-191.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "01e43bc42ee0ae16f1ee6c530b31c0f34edd9cbe65da82f3efb4c023b277cb8d"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-191.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "32186cfb7e895186adaab11a1ac4d0ed39d34c824f07f2ef6fe3d20366a88c4b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-191.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "97de90f82518d10706bf5c1850a8ebcf782b5bc9e24367fe45afde42a5e3c7ab"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-191.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "815e5bd2a51b643fc306c9d03164452770d0ade64b561661d4d41ee5e635d5b9"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-191.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "3c4683ea4dd35b20a6360b284fd6790458e7f27b58e6e2f08fa31f0b1c36c68c"
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
