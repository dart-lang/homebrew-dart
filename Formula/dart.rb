# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.12.0-35.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-35.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "d7109fbb75fa8a175bda560b49149545e242b1ea0f528e8bc4e431183dc85934"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-35.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "05b9728ab294bfdd1e3bf5c1d60c65b52506effb2012f937c15bd284a2edaef2"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-35.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "c0162eb49629b0f07f793f479b41ce9c1dc22f20a2ec545ccbcdd634c6140c0d"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-35.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "432f264407f2eb8182a26c3a81241f2aadecc8c80ad228b3c1232d326a8b802f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-35.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "4865e11f7d51e5d22b76df094eb364ad83e8a1e46a81bb8ccc91066a8120dfac"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.7/sdk/dartsdk-macos-x64-release.zip"
    sha256 "1044b895e3681d9585b3f9d05094f337e702286cf18803692c9ae45dbd5429d0"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.7/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "a2f424bd4e41a6a5c752551e6d428aada9c950446164fb00b1f3b737ee23ccab"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.7/sdk/dartsdk-linux-x64-release.zip"
    sha256 "8a4eeacf4d7690e03389d6328241bc69a1b61cb980f23d50f62ebacb5920ec74"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.7/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "81bdcd8828606981713c513e3d4377eeedec431c46bf35f3277c6abaf2d7bd51"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.7/sdk/dartsdk-linux-arm-release.zip"
      sha256 "9638b38559de736ca6ee1fd4d78b23b3f6c8d341e20b657a2a44ca6b90afda86"
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
