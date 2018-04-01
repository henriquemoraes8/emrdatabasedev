class RecordTypesController < ApplicationController

  def index
    @record_types = RecordType.top_types.includes(:subtypes)
    render 'record_types/index', :status => 202
  end

end
