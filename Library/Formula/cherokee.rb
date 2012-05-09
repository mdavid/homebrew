require 'formula'

class Cherokee < Formula
  homepage 'http://www.cherokee-project.com/'
  url 'http://www.cherokee-project.com/download/pre-releases/cherokee-1.3.0A2.tar.gz'
  md5 'b37b79f5aecb6d95ccd9caf43ebed24e'
  #url 'file:///Users/mdavid/Projects/build/cherokee-1.3.0A2.tar.gz'
  #md5 'b37b79f5aecb6d95ccd9caf43ebed24e'
  #url 'http://www.cherokee-project.com/download/1.2/1.2.101/cherokee-1.2.101.tar.gz'
  #md5 'ef47003355a2e368e4d9596cd070ef23'

  depends_on 'gettext'

  def caveats
    <<-EOS.undent
      Cherokee is setup to run with your user permissions as part of the
      www group on port 80. This can be changed in the cherokee-admin
      but be aware the new user will need permissions to write to:
        #{var}/cherokee
      for logging and runtime files.

       If this is your first install, automatically load on startup with:
          mkdir -p ~/Library/LaunchAgents
          cp #{plist_path} ~/Library/LaunchAgents/
          launchctl load -w ~/Library/LaunchAgents/#{plist_path.basename}

      If this is an upgrade and you already have the plist loaded:
          launchctl unload -w ~/Library/LaunchAgents/#{plist_path.basename}
          cp #{plist_path} ~/Library/LaunchAgents/
          launchctl load -w ~/Library/LaunchAgents/#{plist_path.basename}
    EOS
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}",
                          "--localstatedir=#{var}/cherokee",
                          "--with-wwwuser=#{ENV['USER']}",
                          "--with-wwwgroup=www",
			                    "--with-wwwroot=#{ENV['HOME']}/Library/WebServer"
    system "make install"

    #prefix.install "org.cherokee.webserver.plist"
    plist_path.write startup_plist
    plist_path.chmod 0644
    #(prefix+'org.cherokee.webserver.plist').chmod 0644
    (share+'cherokee/admin/server.py').chmod 0755
  end
  
  def startup_plist
    return <<-EOPLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>KeepAlive</key>
    <true/>
    <key>Label</key>
    <string>#{plist_name}</string>
    <key>ProgramArguments</key>
    <array>
      <string>#{HOMEBREW_PREFIX}/sbin/cherokee</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>UserName</key>
    <string>#{`whoami`.chomp}</string>
  </dict>
</plist>
    EOPLIST
  end
end
