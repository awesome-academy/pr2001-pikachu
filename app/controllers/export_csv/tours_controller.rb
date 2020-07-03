# frozen_string_literal: true

class ExportCsv::ToursController < ApplicationController
  require 'csv'

  def create
    send_data generate_csv, filename: 'file1.csv'
  end

  private

  def generate_csv
    CSV.generate do |csv|
      headers = %w[Name Price]
      csv << headers

      Tour.all.each do |tour|
        csv << [tour.name, tour.price]
      end
    end
  end
end
