# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.15.0-108.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-108.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "4932c2e8a8b84eb3d9f57af83f6f505a334a974f2270ae7bdd57dbb9508dca35"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-108.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "7d6c33735c455dc77fd748be8c0f70e1a8b8b2fb19b31ff4026277f525bf297b"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-108.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "136061dbaad21cbfb257a6f6051b133702f4d2db25f76e28c5ace29019c9bbf2"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-108.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "14fa15ff52dc3c44e0de136ad1a986aab43ea43e863d09e75c2aa0f387e772fc"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-108.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "c1c9cc50cccc9ccd4cca6cd0aed68d750467c6a7aa3b98e432fa987b56478249"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-108.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "da4d6883db2b336cf166fbd56c27cb23df4ed1d57320f0bee2c68bd17d663ce0"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "d0c24bcbda37950ae37e4e7e7cdf93f098cfea8ada39fd7ee6e06c7d97ced704"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "c9e7ec9be908b2f8352730d9475853d008176fc9c00b3484a65033c739c36c61"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "bd352ab4df3de74f837dcc95f86917d925d71793c4b26c2650e0cf814c6e22bf"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "302cba4dea5f772caca6c61be78657a1122a427908d4db04c960b4f004ddb5ad"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "e1e5514fc31457b5743781d72054398492d19a37163ace2ac3913b82017f4acc"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "09f57f277608e52086bd290775ea5991c6eefdbe54e6dc491550fd9ddb7c72f2"
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
