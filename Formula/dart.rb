# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.15.0-133.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-133.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "384c9ad17c06e23082d552fa88e8b4f04210829f71346284bcc87f58aaa753f0"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-133.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "9ce32110d0ac942c983ffe52343009b5386c006738ae886d853f2fab8e33d754"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-133.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "3f90de9d10f9e5f4ec2ede4cd0868ac27464b06de174d2c043a55cf02209ba7a"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-133.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "0e1e3340f2b0edc833053da11369fe8175f1aef21be8c148f1866337af106a5c"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-133.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "8b572162be701a639aa715b74d1b8d0de61e3413f8d473dc27ecbca09fd9d6da"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.14.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "91fff6ade4d81e02a4b568a6f5bfa037756fbfa1cc911c998e006b166547c05f"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.14.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "84ce7e50f18a724d6a29b33af5c4a16b160e9fb64622e12d575b3c9e3420509b"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.14.0/sdk/dartsdk-linux-x64-release.zip"
    sha256 "90f7fd75fe21e16437778df882f280910d9bbd4809c90024f21de82435dded1d"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.14.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "2bb9a19418ced8d9f5cc9e7faa2dcbbc7dc93882b287b8cd8db859efa191c888"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.14.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "ec85c228e7f0acd314c5c8e164f1629b79bddd03c243c31f80ad209420c73ac0"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"].select { |f| File.executable?(f) }
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
