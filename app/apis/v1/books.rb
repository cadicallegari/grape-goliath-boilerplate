module API
  module V1
    class Books < Grape::API

      resource :books do

        get '', :rabl => "v1/books/all.rabl" do
          @books = Queries::Book.new(Book.all).do_query(params)
          @books = paginate(@books)
        end

        get :raw, :rabl => "v1/books/raw.rabl" do
          @books = Queries::Book.new(Book.all).do_query(params)
        end


      end

    end
  end
end
