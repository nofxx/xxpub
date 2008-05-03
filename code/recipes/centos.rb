# # #
# # 
#
#  CentOS 5.1 Capistrano Recipe 
#
#  Based on Peepcode
#
#  Fireho 2008
#
class Capistrano::Configuration

  ##
  # Print an informative message with asterisks.

  def inform(message)
    puts "#{'*' * (message.length + 4)}"
    puts "* #{message} *"
    puts "#{'*' * (message.length + 4)}"
  end

  ##
  # Read a file and evaluate it as an ERB template.
  # Path is relative to this file's directory.

  def render_erb_template(filename)
    template = File.read(filename)
    result   = ERB.new(template).result(binding)
  end

  ##
  # Run a command and return the result as a string.
  #
  # TODO May not work properly on multiple servers.
  
  def run_and_return(cmd)
    output = []
    run cmd do |ch, st, data|
      output << data
    end
    return output.to_s
  end

end


##
# Custom installation tasks for CentOS (RailsMachine).
#
# Author: Geoffrey Grosenbach http://topfunky.com
#         November 2007

namespace :fireho do
  
  desc "Copy config files"
  task :copy_config_files do
    run "cp #{shared_path}/config/* #{release_path}/config/"
  end
  after "deploy:update_code", "peepcode:copy_config_files"

  desc "Generate spin script from variables"
  task :generate_spin_script, :roles => :app do
    result = render_erb_template(File.dirname(__FILE__) + "/templates/spin.erb")
    put result, "#{release_path}/script/spin", :mode => 0755
  end
  after "deploy:update_code", "peepcode:generate_spin_script"

  desc "Create shared/config directory and default database.yml."
  task :create_shared_config do
    run "mkdir -p #{shared_path}/config"

    # Copy database.yml if it doesn't exist.
    result = run_and_return "ls #{shared_path}/config"
    unless result.match(/database\.yml/)
      contents = render_erb_template(File.dirname(__FILE__) + "/templates/database.yml")
      put contents, "#{shared_path}/config/database.yml"
      inform "Please edit database.yml in the shared directory."
    end
  end
  after "deploy:setup", "peepcode:create_shared_config"

  namespace :setup do

    desc "Setup Passenger"
    task :setup_passenger, :roles => :app do
      ##result = render_erb_template(File.dirname(__FILE__) + "/templates/nginx.vhost.conf.erb")
      #put result, "/tmp/nginx.vhost.conf"
      ##sudo "mkdir -p /usr/local/nginx/conf/vhosts"
      #sudo "cp /tmp/nginx.vhost.conf /usr/local/nginx/conf/vhosts/#{application}.conf"
      #inform "You must edit nginx.conf to include the vhost config file."
    end

  end

  namespace :install do

    desc "Install server software"
    task :default do
      setup

#      memcached
#      munin
#      httperf
      tools
      servers

      utils
      git
      imagick
      special_gems
      time
    end

    task :setup do
      sudo "rm -rf src"
      run  "mkdir -p src"
    end
    
    task :servers do
      sudo "yum install httpd"
      sudo "gem install passenger"
    end
    
    desc "Devel-tools"
    task :tools do
      sudo "yum groupinstall 'Development Tools'"
      sudo "yum install ruby ruby-devel rubygems"
      sudo "gem update --system"
      sudo "gem update"
    end
    
    desc "Various utils"
    task :utils do
      sudo "yum install tree bash-completion"
    end
    
    desc "Install git"
    task :git do
      curl
      version = "1.5.5.1"
      cmd = [
        "cd src",
        "http://kernel.org/pub/software/scm/git/git-#{version}.tar.gz",
        "tar xfz git-#{version}.tar.gz",
        "cd git-#{version}",
        "./configure",
        "make prefix=/usr/local all",
        "sudo make prefix=/usr/local install"
      ].join(" && ")
      run cmd
    end

    desc "Install curl"
    task :curl do
      sudo "yum install curl curl-devel -y"
    end

    desc "Install MySQL"
    task :mysql do
       sudo "yum groupinstall 'MySQL Database'"
    end

    desc "Install memcached"
    task :memcached do
      # TODO Needs to run ldconfig after libevent is installed
      run "echo '/usr/local/lib' > ~/src/memcached-i386.conf"
      sudo "mv ~/src/memcached-i386.conf /etc/ld.so.conf.d/memcached-i386.conf"
      sudo "/sbin/ldconfig"

      result = File.read(File.dirname(__FILE__) + "/templates/install-memcached-linux.sh")
      put result, "src/install-memcached-linux.sh"

      cmd = [
        "cd src",
        "sudo sh install-memcached-linux.sh"
      ].join(" && ")
      run cmd
    end

    desc "Install ImageMagick 6.4"
    task :imagick do
      sudo "yum install FreeType libpng libpng-devel libxml2 libxml2-deve"l
      curl
      cmd = [
        "cd src",
        "wget ftp://ftp.imagemagick.org/pub/ImageMagick/ImageMagick.tar.gz",
        "tar xzf ImageMagick.tar.gz",
        "cd ImageMagick-6.4.0",
        "./configure --disable-static --with-modules --without-perl --without-magick-plus-plus --with-quantum-depth=8",
        "make",
        "sudo make install"
      ].join(" && ")
      run cmd
    end
    

    desc "Install gems"
    task :special_gems do
      # TODO hpricot
      %w(rmagick capistrano libxml-ruby gruff sparklines ar_mailer bong production_log_analyzer).each do |gemname|
        sudo "gem install #{gemname} -y"
      end
    end

    desc "Install munin"
    task :munin do
      sudo "rpm -Uhv http://apt.sw.be/packages/rpmforge-release/rpmforge-release-0.3.6-1.el4.rf.i386.rpm"
      sudo "yum install munin munin-node -y"
      post_munin
      munin_plugins
    end

    desc "Post-Munin Tasks"
    task :post_munin do
      cmds = [
        "rm -rf /var/www/munin",
        "mkdir -p /var/www/html/munin",
        "chown munin:munin /var/www/html/munin",
        "/sbin/service munin-node restart"
      ]
      cmds.each do |cmd|
        sudo cmd
      end

      inform "You must link /var/www/html/munin to a web-accessible location."
    end

    desc "Upload and configure desired plugins for munin."
    task :munin_plugins do
      # Reset
      sudo "rm -f /etc/munin/plugins/*"

      # Upload
      put File.read(File.dirname(__FILE__) + "/templates/memcached_"), "/tmp/memcached_"
      sudo "cp /tmp/memcached_ /usr/share/munin/plugins/memcached_"
      sudo "chmod 755 /usr/share/munin/plugins/memcached_"

      # Configure
      {
        "cpu" => "cpu",
        "df" => "df",
        "fw_packets" => "fw_packets",
        "if_eth0" => "if_",
        "if_eth1" => "if_",
        "load" => "load",
        "memcached_bytes" => "memcached_",
        "memcached_counters" => "memcached_",
        "memcached_rates" => "memcached_",
        "memory" => "memory",
        "mysql_bytes" => "mysql_bytes",
        "mysql_queries" => "mysql_queries",
        "mysql_slowqueries" => "mysql_slowqueries",
        "mysql_threads" => "mysql_threads",
        "netstat" => "netstat",
        "ping_nubyonrails.com" => "ping_",
        "ping_peepcode.com" => "ping_",
        "ping_staging.topfunky.railsmachina.com" => "ping_",
        "ping_rubyonrailsworkshops.com" => "ping_",
        "ping_theonlineceo.com" => "ping_",
        "ping_topfunky.com" => "ping_",
        "processes" => "processes",
        "swap" => "swap",
        "users" => "users",
      }.each do |name, source|
        sudo "ln -s /usr/share/munin/plugins/#{source} /etc/munin/plugins/#{name}"
      end
      sudo "/sbin/service munin-node restart"
      sudo "-u munin munin-cron"

      inform "You must may need to run: sudo cpan Cache::Memcached"
    end

    desc "Install httperf"
    task :httperf do
      cmd = [
        "cd src",
        "wget ftp://ftp.hpl.hp.com/pub/httperf/httperf-0.9.0.tar.gz",
        "tar xfz httperf-0.9.0.tar.gz",
        "cd httperf-0.9.0",
        "./configure --prefix=/usr/local",
        "make",
        "sudo make install"
      ].join(' && ')
      run cmd
    end

    desc "Set time to UTC"
    task :time do
      yum install ntpd
      sudo "ln -nfs /usr/share/zoneinfo/UTC /etc/localtime"
    end

  end

end
