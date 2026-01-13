# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.12.0-15.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-15.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "eef1fa762be9cf0e06bc6c36664486e4995cb8d0448c4a93c948ef9c42c8f296"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-15.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "3c64f75861d7143cd39ffb9e6bda3f826ce92609e5f851352861c1709632ea0c"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-15.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "10e31dd3ae1db536b85804cbe210b8cceb8d686b9599ba1082baecf09e2e3631"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-15.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "7f29e07a2921af10e4c9aff48392d027ca32129f54904467ef4b4c9a2cf1283d"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-15.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "58e623698f07319379c44f2b969ee6e2f135d0d21261ef3730203fe06eb35a6a"
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
