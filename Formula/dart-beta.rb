# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.0.0-417.2.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-417.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "63f98c95087d2b03bb5d4088d31aca15cad4afccfba4fb90ea43ff3ce2c435ec"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-417.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "bb37d865e8688aa2ce395878c15416bacaa65b336cfa69ba377c6d58edd00d4c"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-417.2.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "02c21fd46d0be0ea4d184406a8c8446205129db0e19b8feff6a3ab06a127f83f"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-417.2.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "abc7211c5e07930d568abd5ddefe59ad4f4526bc01db105320ab203f0fdb1ca6"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-417.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "4253dae7dfaca493c844e25ba42a504f93ac69174d3b9a2a808068125f245508"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-417.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "b9527f5910f5658c783f8aa5d55f4163fa37047be34b5d068ea6a938bd440f90"
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
