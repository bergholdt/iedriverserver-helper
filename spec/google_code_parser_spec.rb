require "spec_helper"

describe IEDriverServer::Helper::GoogleCodeParser do
  let!(:open_uri_provider) do
    double("open_uri_provider").tap do |oup|
      allow(oup).to receive(:open_uri) { File.read(File.join(File.dirname(__FILE__), "assets/google-code-bucket.xml")) }
    end
  end
  let!(:parser) { IEDriverServer::Helper::GoogleCodeParser.new('IEDriverServer_Win32', 
                                                               url: 'http://selenium-release.storage.googleapis.com',
                                                               open_uri_provider: open_uri_provider) }

  describe "#downloads" do
    it "returns an array of URLs for the platform" do
      expect(parser.downloads).to eq [
        "http://selenium-release.storage.googleapis.com/2.39/IEDriverServer_Win32_2.39.0.zip",
        "http://selenium-release.storage.googleapis.com/2.40/IEDriverServer_Win32_2.40.0.zip",
        "http://selenium-release.storage.googleapis.com/2.41/IEDriverServer_Win32_2.41.0.zip",
        "http://selenium-release.storage.googleapis.com/2.42/IEDriverServer_Win32_2.42.0.zip",
        "http://selenium-release.storage.googleapis.com/2.43/IEDriverServer_Win32_2.43.0.zip",
        "http://selenium-release.storage.googleapis.com/2.44/IEDriverServer_Win32_2.44.0.zip",
        "http://selenium-release.storage.googleapis.com/2.45/IEDriverServer_Win32_2.45.0.zip",
        "http://selenium-release.storage.googleapis.com/2.46/IEDriverServer_Win32_2.46.0.zip",
        "http://selenium-release.storage.googleapis.com/2.47/IEDriverServer_Win32_2.47.0.zip",
        "http://selenium-release.storage.googleapis.com/2.48/IEDriverServer_Win32_2.48.0.zip",
        "http://selenium-release.storage.googleapis.com/2.49/IEDriverServer_Win32_2.49.0.zip",
        "http://selenium-release.storage.googleapis.com/2.50/IEDriverServer_Win32_2.50.0.zip",
        "http://selenium-release.storage.googleapis.com/2.51/IEDriverServer_Win32_2.51.0.zip",
        "http://selenium-release.storage.googleapis.com/2.52/IEDriverServer_Win32_2.52.0.zip",
        "http://selenium-release.storage.googleapis.com/2.52/IEDriverServer_Win32_2.52.1.zip",
        "http://selenium-release.storage.googleapis.com/2.52/IEDriverServer_Win32_2.52.2.zip",
        "http://selenium-release.storage.googleapis.com/2.53/IEDriverServer_Win32_2.53.0.zip",
        "http://selenium-release.storage.googleapis.com/2.53/IEDriverServer_Win32_2.53.1.zip"]
    end
  end

  describe "#newest_download" do
    it "returns the last URL for the platform" do
      expect(parser.newest_download).to eq 'http://selenium-release.storage.googleapis.com/2.53/IEDriverServer_Win32_2.53.1.zip'
    end

    context "out-of-order versions" do
      before do
        allow(parser).to receive(:downloads).and_return([
          "http://selenium-release.storage.googleapis.com/2.52/IEDriverServer_Win32_2.52.0.zip",
          "http://selenium-release.storage.googleapis.com/2.53/IEDriverServer_Win32_2.51.3.zip",
          "http://selenium-release.storage.googleapis.com/2.52/IEDriverServer_Win32_2.52.1.zip",
          "http://selenium-release.storage.googleapis.com/2.52/IEDriverServer_Win32_2.52.2.zip",
          "http://selenium-release.storage.googleapis.com/2.53/IEDriverServer_Win32_2.50.0.zip",
          "http://selenium-release.storage.googleapis.com/2.51/IEDriverServer_Win32_2.51.0.zip",
          ])
      end

      it "returns the newest version" do
        expect(parser.newest_download).to eq 'http://selenium-release.storage.googleapis.com/2.52/IEDriverServer_Win32_2.52.2.zip'
      end
    end
  end
end
