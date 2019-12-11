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
    version "2.8.0-dev.0.0"
    if OS.mac?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.0.0/sdk/dartsdk-macos-x64-release.zip"
        sha256 "b950b7aa7d423f545959cc6eeffc2992caedad12f2981c6561aad0921593116b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.0.0/sdk/dartsdk-macos-ia32-release.zip"
        sha256 "254f910b060d9feb2e171b584b4c96b7d51f2fa060a8c4358d3890bdcd5c0a91"
      end
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.0.0/sdk/dartsdk-linux-x64-release.zip"
        sha256 "b4f5a4b6e16fd98d35eaf85ada18d7f96ad132b0902f7c5949073b65d7890fd3"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.0.0/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "3851c610b21d91b849b7ca6a23f32d8df1cfd8bb33b20081108521b9aff373e2"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.0.0/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "9b9ac44f3d5b6a2807b50b69ce26802aba80ab01133038f103ba7de40f9cec43"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.0.0/sdk/dartsdk-linux-arm-release.zip"
        sha256 "1f55363e9ede1979b4bf7627d4239f52fba652e8999d9d08b1a4b57ca92418c2"
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
