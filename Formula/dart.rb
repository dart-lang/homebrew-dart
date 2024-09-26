# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.6.0-277.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-277.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "2b4005cf92934484f2ef663b8a5e865b4f15821c6d31be40359462f5e4c01e47"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-277.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "0bea92286f34b51e2a474f91156965dd86797104e1701386cace5af15ce2b739"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-277.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "2d01c1faff13323ab0971c8ab5bfa40a8d4810d73494a669ac36e3285de6ce79"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-277.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "9d9bd383545ebe4a768067394c2002e507f4d354bf0c53b978676df7949f4265"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-277.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "e27e2cf1ba0c88f7c2edac06fe5db1c566ab1cbc158f489ea1c55d59c3cc8157"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-277.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "ed61f9f7b67620c5cd627ddea60e1fd03d241b03dd31a732aa1ef6d1d26fa6e3"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "7d673ca3ece0ff563061d65a0e5b84ac8905d26c257fc8dc3d543c8dafa1d0fc"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "c73ea25a5b01312bfad0e222dbd6f0677c46e2a4faa19b9c2b18f8506da03f8b"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "34f6eb82b226dbeaf61ea12a6d9cdd2d3374f7baadc38a6da55545ebc6ba3500"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "5ea88c21ccc5d4388a9d304a47ac4633c40b24d54501ceb1c7b166b14497387d"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "fe82992506112aaf63aebbe2716c133db30ba2c98d97926c0947a2d8d023e5e6"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "30b485142f9bde8a967114a9094d499bdbb1bd3a101adadd5268ce1ac4c617db"
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
