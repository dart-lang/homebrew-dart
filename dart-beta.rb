# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Dart Beta SDK"
  homepage "https://dart.dev"

  version "2.14.0-188.1.beta"
  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-188.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "419b668680b8291974a72bb29bf356c377c83b2361c577410d1f90c8b0bf8f5b"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-188.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "cf34ca396a096999135f9c85ea3408db8e1c9c3d17fab0bde365c91485a2f2d7"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-188.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "330259a854b59f3812124a633de83261325a28bf4bebe6db318895d902bb4fd7"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-188.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "98c06093159127e39707234b11d446218ce3e57d6a77c85d03af508c0ec8dff8"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-188.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "d75315c3a6839c04b6f826c9ca53f1625b730622987afd7f4a38500530522bde"
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
