# typed: false
# frozen_string_literal: true

class DartAT324 < Formula
  desc "SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
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
