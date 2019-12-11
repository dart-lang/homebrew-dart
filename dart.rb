class Dart < Formula
  desc "The Dart SDK"
  homepage "https://www.dartlang.org/"

  version "2.7.0"
  if OS.mac?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.7.0/sdk/dartsdk-macos-x64-release.zip"
      sha256 "f9d2f5b579fe2a1cfd14fe558d20adfa7c7a326a980768335f85ec1ed3611ad2"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.7.0/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "4e0c2a09d85ebbbed55882a105a86a482a151f71a27aec21c2c2125de7b501cf"
    end
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
    version "2.7.0-dev.2.1"
    if OS.mac?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.7.0-dev.2.1/sdk/dartsdk-macos-x64-release.zip"
        sha256 "7c9f2fed89f9670a72d3c4bd60c673ed2ab176d9f65044b08b8d727e70f90c1d"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.7.0-dev.2.1/sdk/dartsdk-macos-ia32-release.zip"
        sha256 "d7156c4d70a153ee133973d61442a72f5a0483af4ffa418df6a60693c192f4f7"
      end
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.7.0-dev.2.1/sdk/dartsdk-linux-x64-release.zip"
        sha256 "071cb515520e057ccc05f4a17f876c7bdc4d61da095dab1f9cbaa9ea4abc542a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.7.0-dev.2.1/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "93ae20a07faac62490410c730be473618843774eef6f14087f895d47ab61c5f1"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.7.0-dev.2.1/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "ed9cd4fda7e0faea293981ade14f8dbbd6bdc3fc2a87e86fd20e3ec28c0aa741"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.7.0-dev.2.1/sdk/dartsdk-linux-arm-release.zip"
        sha256 "dd58defe1b1d279a7f546e60d040ccb434dcc5bd8cd8c13c7d924df0ea851f9d"
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
