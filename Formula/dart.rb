# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.19.0-331.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-331.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "fb4b93351743d7b7188f9442ccddd588a92ad53fcd93a2e9b4a8351f96ed2c50"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-331.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "3870dd95068c8efa6cbb9cdcf5d41f2b27b20a9ce1fd0b92bbee0045f8f56dae"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-331.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "01b0431b650a31fdff359474ecafc4d435baa2e61c6101162b98127f00f838fa"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-331.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "ef704759a12af3af4f56b4d55487a5587116124eb506805a1818c7e7e08390f0"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-331.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "effc3e8793709234ecfe61921bc60232028b2cb819a0b3a17befd1af80e19e7c"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-331.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "1a1ab3d0cbe44ce7e1281472764956442cde7605521230715b1101e0de468e08"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "52ba7072694f7d782633274440fe717c6ac300d4ba4fdbc24bdcd2bae77f4995"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "7295fb2159879aca7dc829be9b123e24d18812ee7108894da5d521724e8e278f"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "77ffe06da481ce420463349d339998dcb122f8c7a857ab96acd35a4652d47e3d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "158facce774258859f5c7a51bda65b981c182fa11a028c154ff032b1302d6add"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "e7ddd9e8c7160b72f61af674e8715f01df4ad445a92685cf86f7b0701fb44027"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "0e5f0f3bf591bbc0a8561171ebfdba3a2da566600d4fcdd6bd6a614201c304e0"
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
