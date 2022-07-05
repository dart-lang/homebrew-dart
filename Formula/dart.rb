# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.18.0-256.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-256.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "28f90d51189c687525c8b100941a0825b957407164a7253bb83f55128655f3bf"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-256.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "065ff844170daa8ac5f59a3d21dfa7eed65c08dbef848ee0936eaf959ab58643"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-256.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "643e37806d55ee1ee811577e76b037634eb9865bec99bd5524f09b06af6196b4"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-256.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "0feef3d892e599295e0e8187dcac5f0c564a05dc8b53e7f9d9d754c0ade6466b"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-256.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "531ba59adaee69b71735c74cd8c507b0ef59ec71edb24daa42782b4113ba0c42"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-256.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "ee3bd6da92e59d82eb682b2054cbe5cfdaf3138055d7256abf76c4ef56dee168"
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
