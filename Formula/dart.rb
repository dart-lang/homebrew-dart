# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.17.0-150.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-150.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "c1107897e85335ae7699f9fa21031418509b8ac9454efe35979f7d806d346c3a"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-150.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "61ddaab2622faa633e10de229279845cb89d77b4440cc1e32243f8c48566af90"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-150.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "94fa7c3bfca2aa79b109bec18df33e29c6f33002eace3ca7672416242a9b3233"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-150.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "aaf2de26bdd16787f2ffc9d354150e2f6814e41d0709519e0ac130ea32af5a0c"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-150.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "cfcadd1bfa14b96735345cd2584bd2f84f6957e6df59658f8aa37c5fd5b685e4"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-150.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "31d7624e2a7c54bd451c7d78ced568d58a131131949d7e59b69678c0e0da3ce4"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.16.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "5c5b5b9f752ce78e7bf6038627cce8b46d8598b4d74bf05a1d226209288bb742"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.16.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "f119516d746b9b10358321d12899444015fecd0223b7add9282648cb57b64d31"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.16.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "3cc63a0c21500bc5eb9671733843dcc20040b39fdc02f35defcf7af59f88d459"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.16.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "c2f815b2c6adcee1dca7d49efa32b22b791b3d10f965fae8f2cebdf5d8d2fdc0"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.16.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "de9d1c528367f83bbd192bd565af5b7d9d48f76f79baa4c0e4cf64723e3fb8be"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.16.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "16e0143716b3ad956fcec78bdb15834bcd67619e61ced0a7806328e9d385b2b3"
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
