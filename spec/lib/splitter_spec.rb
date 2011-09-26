require 'spec_helper'

describe Splitter do
  before(:all) do
    @default_options = {
      :start_wrapper => "<Foos>",
      :end_wrapper => "</Foos>",
      :splitter => "</Foo>"
    }
  end
  context "parse" do
    it "should return nil when provided an empty xml file" do
      Splitter.split(fixture_path("empty.xml"), @default_options) {}.should be_nil
    end

    it "should raise an error if start_wrapper is not provided" do
      lambda {
        Splitter.split(fixture_path("empty.xml"), @default_options.reject { |k,v| k == :start_wrapper }) {}
      }.should raise_error
    end

    it "should raise an error if end_wrapper is not provided" do
      lambda {
        Splitter.split(fixture_path("empty.xml"), @default_options.reject { |k,v| k == :end_wrapper }) {}
      }.should raise_error
    end

    it "should raise an error if splitter is not provided" do
      lambda {
        Splitter.split(fixture_path("empty.xml"), @default_options.reject { |k,v| k == :splitter }) {}
      }.should raise_error
    end

    it "should open the correct file" do
      File.should_receive(:open).once.with(fixture_path("empty.xml"))
      Splitter.split(fixture_path("empty.xml"), @default_options) {}
    end
  end
end
