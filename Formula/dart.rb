# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.7.0-224.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-224.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "517291643e41ed03fcc4013ec8e52e53df42c549164b7d973dd7ad732bbff3f8"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-224.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "5651750a552929043ffbace589ac3771bd332f33b8c433563bf7f4eac331ec7a"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-224.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "0e3423f083712c38f56ec48f4678bb739f9c8118dfeda7d3b102872cf1d54f85"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-224.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "6deea4b810cf5c93d23c44247389fe2674da3153227a9b826d35b9c6134fb372"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-224.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "fed5177585559cca0fa79961c8de60b820744f38986c0688e3007148ebe51e3f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-224.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "d6feb426318a59b813ae53fa2fe62f61c5f943fe2085f36543c41773b71c021e"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "b859b1abd92997b389061be6b301e598a3edcbf7e092cfe5b8d6ce2acdf0732b"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "1bdbc6544aaa53673e7cbbf66ad7cde914cb7598936ebbd6a4245e1945a702a0"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "8e14ff436e1eec72618dabc94f421a97251f2068c9cc9ad2d3bb9d232d6155a3"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "7c8fe91f6ca9f7b2f8216a34e49e9963b38fea8cda77db9ee96f419ec19f114d"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "0f82f10f808c7003d0d03294ae9220b5e0824ab3d2d19b4929d4fa735254e7bf"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "7281158159d65d35d0bee46a97eb425f3efcb53ca3e52fd4901aac47da8af3fc"
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
