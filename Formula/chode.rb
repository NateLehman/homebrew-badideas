class Chode < Formula
    desc "Node.js on ChakraCore :sparkles::turtle::rocket::sparkles:"
    homepage ""
    url "https://github.com/nodejs/node-chakracore/archive/node-chakracore-v8.6.0.tar.gz"
    sha256 "41affaba1970b2b1b1f7e2d266306e4e6c07bb4237e70dce35c7e8bce67c3e47"
    head "https://github.com/nodejs/node-chakracore.git"
    
    bottle do
      root_url "https://github.com/NateLehman/homebrew-badideas/releases/download/v0.1.0/"
      sha256 "0d00d9520dbd5e84f7d220cd19ba31776c8cc6e5eff47bfd98b2e3328530365b" => :high_sierra
    end
  
    option "with-debug", "Build with debugger hooks"
    option "with-openssl", "Build against Homebrew's OpenSSL instead of the bundled OpenSSL"
  
    depends_on :python => :build if MacOS.version <= :snow_leopard
    depends_on "pkg-config" => :build
    depends_on "icu4c" => :recommended
    depends_on "openssl" => :optional
    depends_on "cmake" => :build
    depends_on "node"
  
    # Per upstream - "Need g++ 4.8 or clang++ 3.4".
    fails_with :clang if MacOS.version <= :snow_leopard
    fails_with :gcc_4_0
    fails_with :gcc
    ("4.3".."4.7").each do |n|
      fails_with :gcc => n
    end
  
  
    def install
      # Never install the bundled "npm", always prefer our
      # installation from tarball for better packaging control.
      args = %W[--prefix=#{prefix} --without-npm]
      args << "--debug" if build.with? "debug" 
      args << "--shared-openssl" if build.with? "openssl"
      args << "--tag=head" if build.head?
  
      system "./configure", *args
      system "make"
      system "make", "install"
  
      mv bin/"node", bin/"chode"
  
      rm_rf include
      rm_rf doc
      rm_rf man
      rm_rf libexec
      rm_rf share
      rm_rf lib
      rm_rf etc
    end
  
    test do
      path = testpath/"test.js"
      path.write "console.log('hello');"
  
      output = shell_output("#{bin}/chode #{path}").strip
      assert_equal "hello", output
      output = shell_output("#{bin}/chode -e 'console.log(new Intl.NumberFormat(\"en-EN\").format(1234.56))'").strip
      assert_equal "1,234.56", output
    end
  end
  
