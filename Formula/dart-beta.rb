# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.18.0-271.7.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-271.7.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "b8102b76bad51e36f7c2b7b06bf6884b76182b2848966b5e5daa99f771638a65"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-271.7.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "76155112b021e106d53e5d0d21cecd1d1411625ab240434a615c6caca22c39e7"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-271.7.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "c0f0d03264e9fcc49feda733ac0c3472dd621d406656f169372f849c81b10380"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-271.7.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "2240d66ab721dc37c350a9acce8681c6396e0fe2979aaa22ed5d54dcbe9339a2"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-271.7.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "84c7beeb46ebdcf323c62cdc5c5a95ae958115eb7e738b8d30b3fad43ffcdb4d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-271.7.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "e00442c3d69ae6b0c0904ddfa7e6dfcae8a9c49f32214ce7005b833c3b077c53"
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
