# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.13.0-103.1.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0-103.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "409cda287f8a82015bdbba8987ef9576a567cb8474a54ac3db0d0a0c74892cf1"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0-103.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "8ee8cbfeb3e337b9c9910c13c34a0442c6d75d117dfec8089181f5534d8dc75e"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0-103.1.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "b09a455c98a59469f58a0b4cf7221290e7f79843a077831545f0332c2f4396ee"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0-103.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "3f9f26d4561c8d6c48ce6db1dfca0eb9befaba04c4ed62b557ff58af5c976113"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0-103.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "c902ac4859fcd62f445fe028f8ace678b8694cd8c7566f785bd5e8681cd458a6"
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
