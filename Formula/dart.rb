# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.13.0-139.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-139.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "c61082e9863a0b127f5c8aac819a7f96dd8177531fe9941362ed65e0db97c710"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-139.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "130a29b75e98e8850e5f287eee8b109fa18d3c6f75c67f4103d296afd48ac40e"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-139.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "5e9ce2e3507013a131c17917af0f0118a128c3750cd36d102e1ca1f77bc8f092"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-139.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "64bcd749a27e52d4ab22107048ea806727b4417b7101ad12080a637bfc7d457d"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-139.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "005a07a7e07936a1fcc8e5bfd5060832984be467b79fac15e80c0ce541449faa"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.12.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "c56b322cdbc15e0d7c373970c2e2be53bfb438458bd67c1828703e744acb7916"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.12.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "eaff3823d5a0c5cdcb65b38adf204e5f35290fcd560d48cb47c2fac7e1547b97"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.12.1/sdk/dartsdk-linux-x64-release.zip"
    sha256 "6a2bbf64a133c9c86a62a532dbd3e0b4db4ac365abd456e9f9d1c5df61fcdbf8"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.12.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "b44087930108f6d7f56bf580a02d5d2a97ff94519c5a288339982202e1b4c481"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.12.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "51dfead169350b452a24230b9bcbbf11ac15cda3f993dab32c63a51b3689bbb5"
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
