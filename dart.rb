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
    version "2.8.0-dev.2.0"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.2.0/sdk/dartsdk-macos-x64-release.zip"
      sha256 "7501d16d3413dc33120fbe28e7be88117cf77430b7c278de6be581b0ae3844bb"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.2.0/sdk/dartsdk-linux-x64-release.zip"
        sha256 "4d9037b6367fabf3861d50206be7c17ffd7ef30bf2b6e531919637a1ac5e690a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.2.0/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "1660b146a0a315c4a8ec86c448721ffac4354595ff0c343d48193f3e65123ffb"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.2.0/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "4bcc6e37636fb4dff0eba8c3c89e705d56d3a8646e0b5467b3d80196ae8820aa"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.2.0/sdk/dartsdk-linux-arm-release.zip"
        sha256 "8631d6d4206b638e4db0f5a9b598ccdb7be2041dcd3c4f73797367fbdb470f4c"
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
