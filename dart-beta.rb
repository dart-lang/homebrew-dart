class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.12.0-133.2.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-133.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "26abf875a663d9d44bb3d0fd0ca5687f4bfff06fded16704343660dc35c9b21b"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-133.2.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "f839f06d8ca78ea1bb4580d012ff63c74e213e59a460bb6c62bc9bf4cc3d01db"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-133.2.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "eec64595b61b33fe42eca8244ad0da0066f1387cc1626d9a69c6f984b9a87d45"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-133.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "3e22e265fcd6fc94b4b7499d7a7cd37438b36d5cd2f386e4f539e7b4cfa54c50"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-133.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "5be5f24389a701965cf95b2585ede6303108c5f788523728d04a8f48e84520f2"
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
