# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "Dart SDK"
  homepage "https://dart.dev"

  version "2.13.3"
  head do
    version "2.14.0-228.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-228.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "60e2849781c2bb4cc80804275e7c0f6d94324dc938fbcf9d25aef248190f391d"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-228.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "c7ce93e68714f8ffa9ffd4889ba6e3e3c2816d90cbd5956235aa12aea091ba90"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-228.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "2c22532b397ec5fd1f9f6dbb443e10a637060c37b96793b555a6ba2e808fc8be"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-228.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "ddd9f528c961c1b7e32a0d6b63f848c2935fefb41d619f7470735c34b06b0552"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-228.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "563cc97e242388b08e87d82f121665c72a4cd0ce6855b098f7987ffc5664780e"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "f5ebc9da1554b2901ae8fe46f83db3215acd4579f396d521f506740bde7eb73c"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "b33ef6cc021e88345acd06333ddbbb5771130f4d23fdb6eb79dce7c31b78071c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "5b7f86633c9dc43893a179f8f6c42a74148d348269b0b3e0b40bde05fbd41be3"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "f48adedbf471981b140d37126be0e54af4a167baebdc9e5241656582a930a4d5"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "f5a7dd1598eebd5f0fd20704adf6acc3cd23de1f2b93b6b59a657dd524e14b17"
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
