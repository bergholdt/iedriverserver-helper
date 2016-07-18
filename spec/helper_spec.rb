require "spec_helper"

describe IEDriverServer::Helper do
  let(:helper) { IEDriverServer::Helper.new }

  describe "#binary_path" do
    context "on 32bit platform" do
      before { allow(helper).to receive(:platform) { "Win32" } }
      it { expect(helper.binary_path).to match(/\.IEDriverServer-helper\/Win32\/IEDriverServer.exe$/) }
    end

    context "on x64 platform" do
      before { allow(helper).to receive(:platform) { "x64" } }
      it { expect(helper.binary_path).to match(/\.IEDriverServer-helper\/x64\/IEDriverServer.exe$/) }
    end
  end
end
