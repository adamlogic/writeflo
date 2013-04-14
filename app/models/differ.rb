class Differ
  WORD_TOKENS   = /\w+|<[^>]*>|./
  PHRASE_ENDERS = '\.\?!;'
  PHRASE_TOKENS = /\w[\w ]+[#{PHRASE_ENDERS}]|^[^\n#{PHRASE_ENDERS}]+$/

  def self.tokens(old_content, new_content)
    old_content = DiffableString.new(old_content).normalize_line_breaks
    new_content = DiffableString.new(new_content).normalize_line_breaks
    old_tokens  = old_content.tokenize(PHRASE_TOKENS)
    new_tokens  = new_content.tokenize(PHRASE_TOKENS)

    diff_tokens old_tokens, new_tokens
  end

  def self.diff_tokens(old_tokens, new_tokens)
    token_collector = TokenCollector.new
    Diff::LCS.traverse_balanced(old_tokens, new_tokens, token_collector)
    token_collector.tokens
  end

  class DiffableString < ::String
    def tokenize(regex)
      matches  = scan(regex)
      dividers = split(regex)
      tokens   = dividers.zip(matches).flatten

      return matches if dividers.empty?

      tokens.shift if tokens.first == ''
      tokens.pop   if tokens.last.nil?

      tokens
    end

    def normalize_line_breaks
      self.gsub(/\r\n?/, "\n")
    end
  end

  class TokenCollector
    attr_reader :tokens

    def initialize
      @tokens = []
    end

    def match(event)
      @tokens << Token.new(event.old_element)
    end

    def discard_a(event)
      @tokens << Token.new(event.old_element, :deleted)
    end

    def discard_b(event)
      @tokens << Token.new(event.new_element, :added)
    end

    def change(event)
      old_subtokens = event.old_element.scan(WORD_TOKENS)
      new_subtokens = event.new_element.scan(WORD_TOKENS)

      if old_subtokens.length > 1 || new_subtokens.length > 1
        @tokens += Differ.diff_tokens(old_subtokens, new_subtokens)
      else
        @tokens << Token.new(event.old_element, :deleted)
        @tokens << Token.new(event.new_element, :added)
      end
    end
  end

  class Token < Struct.new(:content, :status)
    def added?
      status == :added
    end

    def deleted?
      status == :deleted
    end
  end

end
