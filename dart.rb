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
    version "2.8.0-dev.4.0"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.4.0/sdk/dartsdk-macos-x64-release.zip"
      sha256 "408780a7c0b495cb6003c285ec60fdf55fed7809c8d6a3281f84b2d47f2901c2"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.4.0/sdk/dartsdk-linux-x64-release.zip"
        sha256 "6c0905cfab18b2e757fb50d0fce6093e0ed34f6430633508307b5557d7bd2631"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.4.0/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "912ac550096de859ed8884484f34bcdeeef418d8ceb12f1b2382b2d1e4765162"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.4.0/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "480f37583e16fcb6d4985575039034e9b5c4696c1bef44f1e912ef3340f5b475"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.4.0/sdk/dartsdk-linux-arm-release.zip"
        sha256 "f1c3a560a18e104b38dbfefc3892fe115078ef2c24b8dd8766a9d523a48ce63d"
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
