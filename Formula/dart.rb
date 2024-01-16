# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.4.0-24.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-24.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "f3cd8065123c147a215cf69ac029eec5b6782ec8ea3d548f63c67da17f8dcf4e"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-24.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "bac5a5e6d974c3238259636bbc26abbb664871a591bb6c98bee8bb88b5017c24"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-24.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "6f43abe4c8ad3a82b4048c80fe71edff99aeb5497af4a13f66c31170db311ab6"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-24.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "26dc9e8bfca8fed8362ea2c1efb51bc5aa129fde8ab74394aab50853f7de7a96"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-24.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "69493b600f1338bd955b24446143a8c9426784d8ea2b779a3450d65034cbebfc"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-24.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "804a400df98cbe74264cbb61930c48adafbc7944c73285b471a50d2243f62479"
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
