# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.18.0-209.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-209.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "aa3e07130f3f066a4f1ab052c0e7c8516db3fa42a1a7722e613e398cc967caac"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-209.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "097aeb59ed62bc5bd1a4cf65f0c0e4e8c0d3ebbd783cc2acafe54abf0b4bcf80"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-209.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "3c15f38a624123afebcb74d9ca604b4bb2a127a22e6f9317051a064056124be2"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-209.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "75f66c0b81bda3fa2edcf2d1f48477dbdaccb8eff94b5d77e1872d7f1624df6d"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-209.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "0ce72e97e2e935a2f319d6ebcf0353ac20f9f0d7b8080e5f413cdb9da7e98b59"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-209.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "44f0a3580208fd875160902d182314afadc8794a348f52cee036d7ac5ddf8ed2"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.5/sdk/dartsdk-macos-x64-release.zip"
    sha256 "55e2ffe2ddbcef88e7a7fcb87348ff10934234f0ecbd9b463316018e8bb7d8a8"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.5/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "ca0c0df7085465a616b86919fa66440632aedfd7a26cda16f3412421f8e6ee96"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.5/sdk/dartsdk-linux-x64-release.zip"
      sha256 "0052467a23ec8d46523be0f29263881444e0da3228860eb6b69de0859aca2459"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.5/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "26dd57fd191638196374bc77059a988b5510d7cb169d3032a2bde47ccc4f1957"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.5/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "0482ba914c7e9befc67d1ff0057bfcae354d6cfeb0d4716f1ff44623089a2688"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.5/sdk/dartsdk-linux-arm-release.zip"
      sha256 "00e855429cd7345a56235a7b216967d23c22d0c1a0417249c4323b1cbfe9af62"
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
