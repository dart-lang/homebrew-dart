# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.6.0-22.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-22.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "20cced5c8935d84c12130ef10e40981a2a713fac5a99b740a55427057d91b4c7"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-22.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "a7dbca0c6e782723fcfcbd1fa05925aa9899bbb1c9a8f54223f86127f2e046a9"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-22.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "d5e9309b96a840c280e8df694ef48622534246754c10c0046f35e42017f49459"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-22.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "625876f0e9c42ec1e6eec8b74532b6b83df4dc055333c3d34775ef7655c7a6f4"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-22.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "0d533e72d1903724169d47687cfc08a017f957e3f976d782c0df9e8d0c08689a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-22.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "2c63828c3e281c3b64e81ff35e8bff73d2592089fa7894369518e48f05e23601"
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
