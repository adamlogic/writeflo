require 'spec_helper'

describe Doc do
  describe "#content" do
    it "delegates to the latest version" do
      version = create(:version, content: 'foo')
      version.doc.content.should == 'foo'
    end

    context "when the doc is new" do
      it "delegates to the version created in memory" do
        doc = Doc.new
        doc.versions.build(content: 'foo')
        doc.content.should == 'foo'
      end
    end
  end
end
