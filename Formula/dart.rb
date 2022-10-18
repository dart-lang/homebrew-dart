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
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "c5c478d97f64b7bdfb5ac4e5c25724af177257691a17c9cfc1b59b069159e61a"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "49fed61ac432440b2817666c8c09040cf586a66536d4ddd9e963dfbc30b29fe3"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "0b7f988de7172ef4a626b2f08bd1fb4e00fd369d0002b456c7711d06b7d0a535"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "87bf5924eae72138708593e24636817f075d38885a6ec08a3de37397f4877e48"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "cf220ad62e7ff4fd82fac8f3740ae1170a553b83fe22dfbf5f9d25fa7f607a42"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "f14ec4fcc222c88dfd5d1fec47ac527ee172e5b974974de9a7c5213922d05e70"
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
