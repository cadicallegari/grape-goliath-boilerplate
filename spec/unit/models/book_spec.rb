#!/bin/env ruby
# encoding: utf-8
require 'spec_helper'

describe Book do

  before(:each) { @book = FactoryGirl.build(:book) }

  subject { @book }

  it { should respond_to(:title) }
  it { should respond_to(:number_of_pages) }


  it "title returns a string" do
    expect(@book.title).to match 'Mock title'
  end

  it "pages returns a number" do
    expect(@book.number_of_pages).to match 99
  end

  it "not valid" do
    book = Book.new
    book.should_not be_valid
  end

  it "title bigger then 3" do
    book = FactoryGirl.build(:book, title: "12")
    book.should_not be_valid
  end

  it "should raise recordinvalid without title" do
    expect {
      FactoryGirl.create :book, title: nil
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "should raise recordinvalid without pages" do
    expect {
      FactoryGirl.create :book, number_of_pages: nil
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "should be valid" do
    FactoryGirl.create(:book).should be_valid
  end

end
