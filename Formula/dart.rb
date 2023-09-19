# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.2.0-171.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-171.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "5392e1d4031d064065a4ffc83f177c91b3030d38ce2c26e3b07fbf7d1f387086"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-171.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "4d700bfe15aa364fb06315344f80666831445ee9d433d9102b93262bee9a315c"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-171.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "f82e490d810263af42de2c6522bef29ca2bc512dbfe0430a261700749e919242"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-171.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "fc8075fa63e6d19ce2a0d8dccadcdf8b32ed56664a0fba06b594f981b854db6e"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-171.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "44aa232c97a459b1fa9919f1e466abf01058d68ea3a04b51a79aa658c67f9672"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-171.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "41faa5b418ce07f9aca5f3992b88ff5a6534098eceeda9069ed27ddf5b83864d"
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
