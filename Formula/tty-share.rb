class TtyShare < Formula
  desc "Terminal sharing over the Internet"
  homepage "https://tty-share.com/"
  url "https://github.com/elisescu/tty-share/archive/v0.6.0.tar.gz"
  sha256 "4de1a017085cc8cd3b81c696ea33507f507e343bda1ddc26e74d5f6c2d865c70"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath

    bin_path = buildpath/"src/github.com/elisescu/tty-share"
    bin_path.install Dir["*"]

    cd bin_path do
      system "go", "build", "-ldflags", "-X main.version=" + version.to_s, "-o", bin/"tty-share", "."
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tty-share --version")
  end
end
