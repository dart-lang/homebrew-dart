# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.18.0-271.8.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-271.8.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "537a6b18545f849230a75780e126e804fcde131526c12f54dcfa52b1f16cd66e"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-271.8.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "4c6a2418849e098ffd719a0a8e9d84f6059a1052272c431ef2e71cd6751b3639"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-271.8.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "b59152692d335ac6e66b67428604739abb5bddb671edce2aed2f2f0fdbca2d8b"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-271.8.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "fcb08c6905647bf85a44128fdc39d300bbce4b9ca42f8afb9fb364a076199303"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-271.8.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "27dfb987a113190df657c31cf3d66854128110b4cba2512f00b8c0fdcc6830a5"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-271.8.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "6d6c82c9cc9db68e266d680c85f4e30cac909acf20090a19e4706f9bdffab4d2"
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
