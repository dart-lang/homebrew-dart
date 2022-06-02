# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.18.0-159.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-159.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "f28e49cb999b3aafa3eb3258c687e30a56185a99e21b811d0def2975cc8359d1"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-159.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "fb3f04cd20b671ad243fbfd295662afcf8e2eb634f5d56b93b7986a1c56e0ea5"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-159.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "cb48b7ee377c1a10f6fbef1f10f8ee11b3384b179f6d481a81a69526e56a1edf"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-159.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "1ef91efd0d0de8ca1de9cb244ac3c8049b1b26ba05a1ed7711259b14065aa40c"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-159.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "fd44a92d866543b0bfa37ae2f72a46490dcfd611d19b235645cfd02f3a15bf51"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-159.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "b4d95e0c0c4ad415745944c0c437d9686fc0f3e8f0c0d47f30fb29dad68b52fd"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "fbacb894e192f15c96ad908c4a02c5ba7d04fd63821a51c413c279710895a546"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "36392a0bd0da68518de3b41ee3ac5496c131d8ed9b42b2a16f5789cb17ebed58"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "68f9a09ac61aab1c135ad2e64a39bfac088900d439941dee275d8ea8c8541b95"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "04520ddfa39445a5888015223b7e4690c9210811e7aad2983c955eb5d2797192"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "c993247b5adaab432fbb4d4b144d5a52c4c4011656312d2b008ef6ec51eaeadb"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "75d1f5969ae12298d27b00bbe5866cdfcad422102929b52dc035c264ecc979a9"
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
