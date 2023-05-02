# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.0.0-417.4.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-417.4.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "394bac90e320af38e69b5a2e9d7719504671f6568b75fe5f3e11fd1e487f6368"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-417.4.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "d057de1c1b0ea5e23d7c48b341fbf9afa4c70e12c3334c25a47497d78ce08a87"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-417.4.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "d287ee249beb4a0cd869bc7d89c154a1fd444d4980e124eafc60241023a3bf4b"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-417.4.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "acf0f75ca9a3f8cc1f3f12214b101d3eb9e822c547098aa77fa93de7e72de336"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-417.4.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "86ae45811c30d500ae65e22606fc42e07bc2146d1ab42dc17a7fdbcbf940d82f"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-417.4.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "89fec24ce5ea755e7929f756b85d423842bee8647f183c5473c3b6f8ceb9bc4d"
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
