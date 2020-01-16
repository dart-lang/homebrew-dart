class Dart < Formula
  desc "The Dart SDK"
  homepage "https://www.dartlang.org/"

  version "2.7.0"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.7.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "f9d2f5b579fe2a1cfd14fe558d20adfa7c7a326a980768335f85ec1ed3611ad2"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.7.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "65844622eb095be903d057d78af4826bfc204d8ea156f77a14b954520f019827"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.7.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "a503731077c332fbde70c06b602efc5024d59e7331f08dba087d2d8bbf4e6c23"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.7.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "0328af535743622130fa7b89969bac34b11c116cb99d185ad1161ddfac457dec"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.7.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "2270ae2d3e467c539dcc6358312bba949f2614f7da78225e7a1ba5b57981ca0c"
    end
  end

  devel do
    version "2.8.0-dev.3.0"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.3.0/sdk/dartsdk-macos-x64-release.zip"
      sha256 "8f75a35717d708d0a65cab3a6c79f02c8b42f54349a56288c70316ba831a296c"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.3.0/sdk/dartsdk-linux-x64-release.zip"
        sha256 "b4e6e89d042990d90fa44a1fc3c75a956fa785a65db36d99a7619a5d2fa583d1"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.3.0/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "2d12ab269b5fb3b9af5ed73e8c4fcd4c39442a9e8c517c4f1f6776723741343a"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.3.0/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "cd2759d9fc7b00520a5921534dc3037fbb47f1568893c1149b44cbeb0d2aced5"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.3.0/sdk/dartsdk-linux-arm-release.zip"
        sha256 "7263a659f3bb669490fd22dd827e032d1518923e7d56f1c3aebc7b0753638414"
      end
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"]
  end

  def shim_script(target)
    <<~EOS
      #!/usr/bin/env bash
      exec "#{prefix}/#{target}" "$@"
    EOS
  end

  def caveats; <<~EOS
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
