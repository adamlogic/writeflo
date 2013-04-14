require 'spec_helper'
require './app/models/differ'

describe Differ do
  it "does simple diffs" do
    d('one', 'two').should == ['-one', '+two']
    d('one', 'one two').should == ['=one', '+ two']
    d('one two', 'one').should == ['=one', '- two']
    d('one two', 'one three').should == ['=one ', '-two', '+three']
  end

  it "keeps sentences in tact" do
    d("I foo\nI bar", "I bar\nI baz").should == ["-I foo\n", "=I bar", "+\nI baz"]
    d('I foo.', 'I foo. I bar.').should == ['=I foo.', '+ I bar.']
    d('I foo. I bar.', 'I foo.').should == ['=I foo.', '- I bar.']
    d('I bar.', 'I foo. I bar.').should == ['+I foo. ', '=I bar.']
    d('I foo. I bar.', 'I bar.').should == ['-I foo. ', '=I bar.']
    d('I foo! I bar.', 'I bar.').should == ['-I foo! ', '=I bar.']
    d('I foo? I bar.', 'I bar.').should == ['-I foo? ', '=I bar.']
    d('I foo. I bar. I baz.', 'I foo. I baz.').should == ['=I foo.', '- I bar.', '= I baz.']
  end

  it "groups sets of newlines as a separate token" do
    Differ.tokens("I foo.\n\nI bar.", "I foo.\n\nI bar.").should have(3).items
  end

  def d(old, new)
    words = Differ.tokens(old, new)

    words.each_with_object([]) do |word, results|
      current_result = if word.added?
        "+#{word.content}"
      elsif word.deleted?
        "-#{word.content}"
      else
        "=#{word.content}"
      end

      previous_result = results.last || ''
      if current_result[0] == previous_result[0]
        results.last << word.content
      else
        results << current_result
      end
    end
  end
end

describe Differ::DiffableString do
  describe "#tokenize" do
    it "returns all matches and everything between the matches" do
      str = Differ::DiffableString.new("foo")
      str.tokenize(/\w+/).should == ['foo']
      str.tokenize(/\s+/).should == ['foo']

      str = Differ::DiffableString.new("foo bar")
      str.tokenize(/\w+/).should == ['foo', ' ', 'bar']
      str.tokenize(/\s+/).should == ['foo', ' ', 'bar']

      str = Differ::DiffableString.new("foo bar ")
      str.tokenize(/\w+/).should == ['foo', ' ', 'bar', ' ']
      str.tokenize(/\s+/).should == ['foo', ' ', 'bar', ' ']

      str = Differ::DiffableString.new(" foo bar")
      str.tokenize(/\w+/).should == [' ', 'foo', ' ', 'bar']
      str.tokenize(/\s+/).should == [' ', 'foo', ' ', 'bar']
    end
  end
end
