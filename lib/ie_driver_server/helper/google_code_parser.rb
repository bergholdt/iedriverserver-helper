require 'nokogiri'
require 'open-uri'

module IEDriverServer
  class Helper
    class GoogleCodeParser

      attr_reader :source, :driver_name, :url

      def initialize(driver_name, url: , open_uri_provider: OpenURI)
        @driver_name = driver_name
        @url = url
        @source = open_uri_provider.open_uri(url)
      end

      def downloads
        doc = Nokogiri::XML.parse(source)
        items = doc.css("Contents Key").collect {|k| k.text }
        items.reject! {|k| !(/#{driver_name}_/===k) }
        items.map {|k| "#{url}/#{k}"}
      end

      def newest_download
        (downloads.sort { |a, b| version_of(a) <=> version_of(b)}).last
      end

      private

      def version_of url
        Gem::Version.new grab_version_string_from(url)
      end

      def grab_version_string_from url
        url.match(/_(\d+\.?\d+\.?\d+)\.zip$/).captures.first
      end
    end
  end
end
