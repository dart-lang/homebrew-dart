# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.0.0-179.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-179.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "01325eb46a95a40cf2a228986bdba2f7fa5343fe545db5c3cf3dfbbc8b0ddd68"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-179.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "96b5d67bb37abc0deebcfd0b8d6a058818f1a36b84e912f959da7218a7d4739f"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-179.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "811e9a4c0d26352e2cfee67450500f508d222c3d8b54feb6d0b1a46112d1b6ec"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-179.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "4a8c050904c97d44f024c01e022d5b6370af8640737ea2b424345931f768a8a0"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-179.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "9e28511e265ef5bd17800de2d85796adf2203ffa36e7cb39c76dbca85c4229c8"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-179.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "825d5540d37256c9d83262951b26e57fc24e73d2211e31c61cff9ebfa022f642"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "ec29555e3ae0f739c9e86296dd0ccf88e8e43c7eb50d01e247379fcae8d78632"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "dec16f17d942e7c70cc385c672a81dd56118d49c32008f97bf9fc590bcedcbac"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "1390ab623dab8e6c23036e865cc8b6245476797f69c4c855e41bf9ff45928263"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "108d194601ec139dd2de8e079a5906adafe43f0cbceb347dfcd7256c7774796b"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "ba6ccdf8d73ada5be6533cf58a97044ef1180e2d0cd4c7e17da21b62bca65042"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "80b8abc7b3425561712bad6f6d7123217a26fa7697f8aac6dbf0e1e89ee6ea53"
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
