module Queries
  class Base

    def initialize(bases)
      @bases = bases
    end

    def do_query(values, attribute = "name")
      unless values[:query].nil? and values[:query].blank?
        q = values[:query]
        @bases = @bases.where(@bases.arel_table[attribute.to_s].matches("#{q}%"))
      end

      @bases
    end

  end
end
