require 'formula'

class Libaacplus < Formula
  url 'http://217.20.164.161/~tipok/aacplus/libaacplus-2.0.2.tar.gz'
  homepage ''
  md5 '3fc15d5aa91d0e8b8f94acb6555103da'

  # depends_on 'cmake'
  depends_on 'fftw'

  def install
#	ENV.O3
#    	ENV.gcc_4_2
  	inreplace 'autogen.sh', 'libtool', 'glibtool'
    system "./autogen.sh",  "--disable-debug", 
                            "--disable-dependency-tracking",
                            "--with-fftw3-prefix=#{HOMEBREW_PREFIX}",
                            "--prefix=#{prefix}"
    system "make"
    system "make install"
  end

  def test
    # This test will fail and we won't accept that! It's enough to just
    # replace "false" with the main program this formula installs, but
    # it'd be nice if you were more thorough. Test the test with
    # `brew test libaacplus`. Remove this comment before submitting
    # your pull request!
    system "false"
  end
end
