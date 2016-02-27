module Helper
  class Pagination

    def pagination_hash(object)
      {
        total:        object.total_count,
        total_pages:  object.num_pages,
        current_page: object.current_page
      }
    end

  end
end
