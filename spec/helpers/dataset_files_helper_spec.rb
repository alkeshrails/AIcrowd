# -*- encoding: utf-8 -*-

require 'rails_helper'

describe DatasetFilesHelper do

  
  describe '#file_info' do
    it 'works' do
      result = file_info(file)
      expect(result).not_to be_nil
    end
  end

end