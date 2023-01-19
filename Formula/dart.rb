# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.0.0-128.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-128.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "ce4396979e3155e427b64dd69f6e5bc07c3747d9bc743c04c8490fcfc46b48e8"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-128.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "3ca6fe1c507cc9c53cbb6188d140244bfdf5c3deed5cd5e045ef6f012b7bd99c"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-128.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "c8124e3b9527eda9c69dbed7153cf11ff65788e620bf2404f8e9abe1a8032225"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-128.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "dd33999b6141757de044411d701eb7b01124c98fa0f53a77c66160eb0ad07b37"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-128.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "1f5475f68fb1f6325be3b79630033e124f97044182626d3723117a23d5075e32"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-128.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "d9763fdf50a628fa7640818d65c3d6ef08d20af7141cbf5ba22418953a8338f9"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.7/sdk/dartsdk-macos-x64-release.zip"
    sha256 "71675de774e19ccc872234ffcbd96401af49b88330001aeb47cff648eee790ca"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.7/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "2742114776a5b476f64cb96596eaeb2d346f65686b7f358b06de83f0e3eb2a48"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.7/sdk/dartsdk-linux-x64-release.zip"
      sha256 "337de0ad3ee66dca7ffa81fc3cd9ecd53d4593384da9d1dfcf4b68f69559fa2b"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.7/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "3a02c848c1ea1ae2f7b0cae28ed5ec6a0160a795b7440e2e217aafa3eabeb0d3"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.7/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "684092802f280ca7a64b111da647bbd380d2ce5adf8a23bcd70cc902a3c4a495"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.7/sdk/dartsdk-linux-arm-release.zip"
      sha256 "daa5139774ba50f100115c79dc193c0bb0a48737c79eb915ee8f25c4ec74ace1"
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
