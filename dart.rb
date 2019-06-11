class Dart < Formula
  desc "The Dart SDK"
  homepage "https://www.dartlang.org/"

  version "2.3.2"
  if Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.3.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "2643c435c4c8fe1b39c9d73cb63ba8a170ac42609b6e91e08416911bc0418031"
  else
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.3.2/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "d92aa28a3c1742130f92e70c0bf767f7c3f6456392d7bc93fdefbfcfbb5a0e99"
  end

  devel do
    version "2.3.3-dev.0.0"
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.3.3-dev.0.0/sdk/dartsdk-macos-x64-release.zip"
      sha256 "89e10558d976e03a8ac8c1716dcda5b75929cfcf2eba175d570ca4dd6a814318"
    else
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.3.3-dev.0.0/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "254d25c37add303161a0bd9b31e9554edab1d02cdddf8ef52ed2b9a027b607db"
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
