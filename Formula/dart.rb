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
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "2163b8a6bd5be8d54036335204a357f9568068b6276dccf7b7c22a732bc973c1"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "69d0611f528d77aa2a090d34021511f8bf4c441a96e0fcecfc046a2bce5c0ac5"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "aa2abe166d898b1bc1f67f87836d52087ec29c19e6f8940b4c370f969899d44a"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "14fc9684d784d5f73c72bbb9e9603acf36caf082f224023dcda312d450f7fa51"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "71f312f7448d42386b23361b82380cba2b0f0d60406190d25714b9d21e6f7208"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "c1f7bf9e077927beb6dff5d4d124197341ee89dcfedc1dd153de09aaa4818368"
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
