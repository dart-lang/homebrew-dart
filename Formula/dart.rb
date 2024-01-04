# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.3.0-277.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-277.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "a4516519d3da2416d8b6ec19ad8434e64172239e5b07d66815b6c73255b189e4"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-277.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "afaf1b2d0cac348b12e262a43742cd1833fbd6548400716a552a18c616a9e840"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-277.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "d78acb559f6c9147cd6d6e05f1d913d33316b790aeca2cb48da9e5215d4ba303"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-277.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "6a3862f02f7240c556d274e7f8a30b8d14dc80e49e868eacbdcc878d10490814"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-277.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "49bc253226a4f14feb6173519a14a286ce046288b026790d9a144e73e00f7f52"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-277.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "bac0428046a4d47c5a8e19bee9c6891041ca0a7616b172da7d24f67990009d49"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "02d8d72d7c3905c5f009f26e00ab9b787d187d1cdafd2066e1bd12646ac1fa80"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.4/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "4b69e962098dbe1de2365004fab48a1e3c8302540df2827ceb60445a6a634b22"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "7604c091455b7c3e4b3f52a5966b07f4accb657954c54257fe84cddfc77379ae"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "f1a17787cfb3eacc205bae68549c4339048d092157d285cd3dd4afa3818aad49"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "5a3084385df7014fea762fbb8cb985364f65a041a1446db6955cdac670cc8038"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "7b9f271fdec969529402d793b6a5d4c4006b986d027311f13b213be3199c9869"
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
