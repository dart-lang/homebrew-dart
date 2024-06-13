# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.5.0-259.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-259.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "8d1945ecfcdc88fe7f4668191ab68a1ea5bc3ed46c7e4210ac4cfd8775fd062f"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-259.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "b38987884a14f6b12b4eea27953e0e609b32525153c52775f023ed9821ada620"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-259.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "5ead5032ccdb20350e09df3d466d26609729c402e35665c56ffb2ecb10e2566e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-259.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "6541c9f4b7b5ece2963f4ae36ddf744dd38ea71bc4b72836f0a1a26a975bc52d"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-259.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "c8576a7f41688720b6ced61c4152e698c60b9b7db716a00ff4f750448615b48a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-259.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "c28e5815bbd05ce0d3bb2e0f0fc3356c6e59048068f51d48b86ac00baf16e7fe"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "fda7beb096ef3a2311f4f11ab774146fc8352fc73f154132f7c76404a780f9c8"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.4/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "ca750214e3fe0f88c0fb07b22f523c53a307c184f2ed51c3d3dcd2cb9e7bc317"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "1968cc9ee12802317f9a2320165f6966cf949dc3574cac1cb91a1bc7f0de67db"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "a2ce567c7953c901af15e5ce89436d611f601bbc64f0f4a920700e9f1d61f902"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "b4cee491863d2ca6c324fad2d8fe2dfa123f78164630d7ca5eee45b940f70346"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "2ef98f20dd52440bc664d7f215ac888a40755878a0e96cd4356a8cbbf0c20b6e"
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
