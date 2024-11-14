# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.7.0-132.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-132.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "9ab82215cc7e2a66984775f3f7dd18501e096c332884688c1f05028fdb04bef1"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-132.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "e53c11e3c9a491f6e74766e3178185554d5d8e824a6226d0d09130e912b194a6"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-132.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "0c59d3f35870886f4096a7776584cf615b7e4ef35d4fea52ad9a2012fd41302f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-132.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "df8561648939293cdc59fd0e3789bb663484df42986946ad4bcb864e563a2696"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-132.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "272059d30205eb7c193aaf637f89892e1e9b25ae2f8aa81b2ea9ddd900946530"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-132.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "780673682a5203763168352128dcded330bd4f9d938cb302a467501a2f68a457"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "b06db3f3d0e92af0939ca467e87ecababa96da4f9fe5031a788304b5df949374"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.4/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "c045940e0f5d4caca74e6ebed5a3bf9953383e831bac138e568a60d8b5053c02"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "8d0c5e34f2a9d6b9f5ebf05252ae1703893f6087d547c631b390aef2d0cd6967"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "2f90a98cfd45427555b06aac813f70573ed5882a512c3f2cf1e732ae53087b0a"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "a91d64dd3173349cee58c82f5ebf18bb9670f65eecc26d5684124c3def3f83ec"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "f56d635ae4119f78ed887eaf8fb5e7821405fc10816d8ef42d3a9105c7ffb1f4"
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
