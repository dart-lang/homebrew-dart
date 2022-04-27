# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.17.0-266.7.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-266.7.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "e48533d9a1f487217cd1263f4c06fd76c61c24c13f925eedc74bfc6f6bffa0eb"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-266.7.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "437bd1f6a317f77da5cfba7808f72fe7983788309011a3d00659b4a4e39310f3"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-266.7.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "c1417589e4ab70d79a88fafdd417bea30919c6026858f930cd5b7c976752afb6"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-266.7.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "dc778094222a4f85f18ff402a173bdf2beed9e513ea3ddb08db355365bea422d"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-266.7.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "0bc1d229ecf27f084cc091feccfcd819a9281434362f45363632cfa8cb44c68a"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-266.7.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "48faf51274672c4953ede2659c409f1bcf788e867421008df160956a6e03817f"
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
