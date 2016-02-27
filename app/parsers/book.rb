module Parser
  class Book

    def initialize(attributes = {})
      @attributes = attributes
    end

    def parse(values = {})
      return nil if values[:book].nil?

      book ||= ::Book.new

      book.title           = @attributes[:title]           rescue nil
      book.number_of_pages = @attributes[:number_of_pages] rescue nil

      book
    end

  end
end
