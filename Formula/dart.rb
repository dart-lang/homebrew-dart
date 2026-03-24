# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.12.0-274.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-274.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "38ee4090a9fe46c561d0fec48fe7f26492a83afcbd17940040902315cb658112"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-274.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "a2304fb96bc6543938c720576698a834f100c419f24b0ee04223063f2fbb7827"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-274.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "fdd0557bb643b4bdaf2a99307f0e97e0cf5277ad02507dcf80b25b77e60ad610"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-274.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "058e9b40a185ac5a6dbe41944542deebbf27689df37ba37e805e88950ef2343c"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-274.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "856def1d523b13beb30567f319481e285539f6429ef82cf463071cb38c0c1030"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "27b5ecf74973520627c217bb0e9b1dcc0dd531eddeb8cca577bf152096a7e7ed"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "d6ea15796e7976636b361bb935054934fcba3d05edfae8a4ec7bf39d43dbbcd6"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.3/sdk/dartsdk-linux-x64-release.zip"
    sha256 "119f4d0d51b3697e8435a2aaa19d58727c1b92f00e7e8084ba3539cb3fc65fac"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "69edeb88a9adebd64019cbec13285433943f0f24aa79d9d108fdcd69fc84ac2e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "7994384fe0ce1c26ff7da2ba3d49a4c46fad471d6c252d79c742415aa464f066"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"].select { |f| File.executable?(f) }
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
