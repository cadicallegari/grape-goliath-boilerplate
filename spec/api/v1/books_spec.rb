#!/bin/env ruby
# encoding: utf-8
require 'spec_helper'

describe API::V1::Books do
  include Rack::Test::Methods

  before { app.before { env['api.tilt.root'] = 'app/views' } }

  def app
    API::V1::Books
  end

  describe "GET /v1/books" do

    context "filters" do

      before(:each) do
        (1..3).to_a.each do |n|
          FactoryGirl.create(:order,
            alias: "P 00#{n}",
            contract_id: secondary_contract.id,
            counting_period_id: "allooou#{n}"
          )
        end
      end


      it "returns orders" do
        get "/v1/orders"
        last_response.status.should eql(200)
        hash_response_body["list"].size.should eql(3)
      end

    end
  end

end
