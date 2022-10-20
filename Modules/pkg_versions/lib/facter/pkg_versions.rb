require 'puppet'

package_list = "/etc/puppetlabs/pkg_versions"

if File.exist?(package_list)
  File.readlines(package_list).each do |l|
    l.strip!

    @pname = ""
    l.split.each do |p|
      if @pname.eql? ""
        @pname = p
      end
      pkg = Puppet::Type.type(:package).new(:name => p)
      v = pkg.retrieve[pkg.property(:ensure)].to_s
      if !v.eql? "purged" and !v.eql? "absent"
        Facter.add("pkg_" + @pname + "_version") do
          setcode do
            v
          end
        end
      end
    end
  end
end
