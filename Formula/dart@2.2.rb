# typed: false
# frozen_string_literal: true

class DartAT22 < Formula
  desc "Dart SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.2.0/sdk/dartsdk-macos-x64-release.zip"
      sha256 "9438afb49b69ac655882036c214e343232fdcd5af24607e6058e2def33261197"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.2.0/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "78a2da74ea83ee092463a9901467492ef885f6e378353b0a44481fdf40ea81c7"
    end
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.2.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "89777ceba8227d4dad6081c44bc70d301a259f3c2fdb4c1391961e376ec3af68"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.2.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "d6d5edab837301bde218c97b074af8390d5dbe00a99961605159fa9e53609b81"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.2.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "f11926f39cee0157e447a6663370a58f2adf0f8adbff16cce5b5b91c24aa1347"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.2.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "93820f2987efac04c50a3ac350d50f5a233c20dd011d36cefbcf6665d460579c"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"]
  end

  def shim_script(target)
    <<~EOS
      #!/usr/bin/env bash
      exec "#{prefix}/#{target}" "$@"
    EOS
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
