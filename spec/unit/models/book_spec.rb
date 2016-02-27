#!/bin/env ruby
# encoding: utf-8
require 'spec_helper'

describe Book do

  it "should not be valid" do
    book = Book.new
    book.should_not be_valid
  end

  it "should have a name bigger then 3" do
    book = Book.new(alias: '12')
    book.should_not be_valid
  end

  it "should raise recordinvalid" do
    expect {
      FactoryGirl.create :book, alias: "1"
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  let(:company_type) { CompanyType.create name: "Teste Type" }

  let(:first_company) {
    Company.create(name: "First Company", company_type_id: company_type.id )
  }

  let(:second_company) {
    Company.create(name: "Second Company", company_type_id: company_type.id )
  }

  let(:primary_contract) {
    PrimaryContract.create(name: "Contract 1", company_id: first_company.id)
  }

  let(:secondary_contract) {
    SecondaryContract.create(
      name: "Contract 1",
      primary_contract_id: primary_contract.id,
      company_id: first_company.id
    )
  }

  it "should be valid" do
    book = book.new(
      alias: 'client alias',
      contract_id: secondary_contract.id,
      counting_period_id: "ooi"
    )
    book.should be_valid
  end

  it "should raise error" do
    expect {
      FactoryGirl.create(:book, alias: "Valid name")
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "should have an alias" do
    book = book.new(
      contract_id: secondary_contract.id,
      counting_period_id: "ooi"
    )
    book.should_not be_valid
  end

  it "should have a contract" do
    book = book.new(
      alias: 'client alias',
      counting_period_id: "ooi"
    )
    book.should_not be_valid
  end

  it "should have a counting period" do
    book = book.new(
      alias: 'client alias',
      contract_id: secondary_contract.id,
    )
    book.should_not be_valid
  end

  it "should be valid too" do
    FactoryGirl.create(:book,
      alias: 'client alias',
      contract_id: secondary_contract.id,
      counting_period_id: "ooi"
    ).should be_valid
  end

end
