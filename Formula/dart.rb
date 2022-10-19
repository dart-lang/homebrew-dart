# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.19.0-311.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-311.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "636029051963ced8a0d8a795c531384b41c1750f19010d0997f66ac653ad4736"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-311.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "c7168565389ef5dfe47d81ca880ad1c4b58d003d763ea2968852ffd45a66dc44"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-311.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "0a99e56896b4d59bddb8ee1575664a4966d078969ca3cf1e20bad7d96f7bc6f2"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-311.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "01f5f7ba914df1108a41b53d2d286a22ff359b86914aae783c9fe0fe3885be3a"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-311.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "23377fd2ad3386065348cc46617cfe721a2b9b93dcb005dcf7dae96db123299a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-311.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "b357804a1336d5ccb764938921eebc0d9dc76c4740a11622afb6ea55d9ca03ce"
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
