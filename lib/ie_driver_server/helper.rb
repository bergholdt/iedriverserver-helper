require "ie_driver_server/helper/version"
require "ie_driver_server/helper/google_code_parser"
require 'fileutils'
require 'rbconfig'
require 'open-uri'
require 'zip'

module IEDriverServer
  class Helper
    BUCKET_URL = 'http://selenium-release.storage.googleapis.com'

    def run *args
      download
      exec binary_path, *args
    end

    def update
      download true
    end

    def download hit_network=false
      return if File.exists?(binary_path) && ! hit_network
      url = download_url
      filename = File.basename url
      FileUtils.mkdir_p install_dir
      Dir.chdir install_dir do
        FileUtils.rm_f filename
        File.open(filename, "wb") do |saved_file|
          URI.parse(url).open("rb") do |read_file|
            saved_file.write(read_file.read)
          end
        end
        raise "Could not download #{url}" unless File.exists? filename
        extract filename
        FileUtils.rm_f filename
      end
      raise "Could not unzip #{filename} to get #{binary_path}" unless File.exists? binary_path
      FileUtils.chmod "ugo+rx", binary_path
    end

    def remove
      FileUtils.rm binary_path
    end

    def binary_path
      File.join install_dir, "IEDriverServer.exe"
    end

    private 

    def extract filename
      Zip::File.open(filename) do |zip_file|
        zip_file.each do |entry|
          FileUtils.rm_f entry.name
          entry.extract(entry.name)
        end
      end
    end

    def driver_name
      'IEDriverServer_' + platform
    end

    def download_url
      GoogleCodeParser.new(driver_name, url: BUCKET_URL).newest_download
    end

    def install_dir
      File.expand_path File.join(home_dir, ".IEDriverServer-helper", platform)
    end

    def platform
      !!(RbConfig::CONFIG['arch'] =~ /_64/) ? 'x64' : 'Win32'
    end

    def home_dir
      ENV['HOME'] || ENV['HOMEPATH']
    end

  end
end
