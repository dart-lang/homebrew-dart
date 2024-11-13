# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.6.0-334.4.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.6.0-334.4.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "a24acdb76c160bb55dcd80ba4e04fb076277b519a2388470421ab8564e43a89a"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.6.0-334.4.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "795e1ecefed232a095156cfb8004745825afd01bbcd7602ad474044fabd02a3e"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.6.0-334.4.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "4a97e00d073c74af8b14d45f3251db2f3a3e9718be4be754366b24d50b356ccc"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.6.0-334.4.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "b88b4b5cb9a624364ec4f8cec6ff6f4ba17f2a93e2344fe376b1ea23b03021cf"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.6.0-334.4.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "df78b887350eaf0fe4ccda373ce1359461d5e70761d1f79945af028d5dc70e52"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.6.0-334.4.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "7f21ebfd01e965e3fe2b63c90b440a671e6233c851e8b16f58f52d693844d8c3"
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
