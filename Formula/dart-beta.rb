# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.9.0-100.2.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.9.0-100.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "f2cdbdd5ffd2ccd7b4355478b9f9f440e79d3f94a094de86b3c609f4728723fe"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.9.0-100.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "73063836c198c6ebcf09d9d38737badfc86bfa8dd8316fe7bd85d144d8c9dec9"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.9.0-100.2.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "9b503e642c862f404b46490cb6ba652c71d276fb7eb415283abe172a8574806f"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.9.0-100.2.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "null"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.9.0-100.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "fd0871a012ccc9c49ee8e9b2e6ba0ea36336c7cc38af05646ca513c4ccb0b616"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.9.0-100.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "de3439e67cf932c8d1f5fc82e8b68635cebcb8b0fb95a52a3a34122027c1cc51"
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
