# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.0.0-163.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-163.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "8325e9c243fbb5487dc3b9ccaa12f27c98d513aca632dead21a35088d0924ed9"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-163.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "eefe92d9682de15ee39dc9aa99716353d2c19a09359aeb8f7d59edf21f8cfcaf"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-163.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "13c1a9d685a238d7e3b7ac4674a268c33c745813c9d061518176b8ca2cf9efda"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-163.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "0eee06720103ec3e265dd937b44b99a63227089fe519a7093e5235e1aade78a8"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-163.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "4ae71b9f2cebf2743a16f49a64e2d8a5e7b1155e128432639b4d489a141c9a02"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-163.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "5594163f0fdf087b4271f3f51df8c8a0489dddad22a018d17e303bcd2fcc7796"
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
