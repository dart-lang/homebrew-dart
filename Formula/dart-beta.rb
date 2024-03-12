# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.4.0-190.1.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-190.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "8ba8bd9c5d5f17ee901c1fd4f11ec6d12f1932e462fc3bcbe11d35f89b6486ea"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-190.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "f15a444711ccd8dc34ac9d028af1b5675656d03a6377f42679d4f2ba9d3db757"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-190.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "386afc91963c3de7dc35d7c26b324389edc8f0685c72e85134f3afff5c9b69e0"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-190.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "c30d450a73b95c15f234e59493694b606216d66b4512e3ceba4c20851b1b7329"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-190.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "54fdb89e54964120d24a01fb626fe59a5d6d6f1e460ceeac97918340c2999b95"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-190.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "f67cf0013ac548a08a7fe1432cbf0cbd5862558b9a84b175617def9ee16ca0ba"
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
