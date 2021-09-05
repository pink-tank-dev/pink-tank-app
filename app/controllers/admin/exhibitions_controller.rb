module Admin
  class ExhibitionsController < ApplicationController
    before_action :set_exhibition, only: %i[edit update show]
    def index
      @exhibitions = Exhibition.all
    end

    def new
      @exhibition = Exhibition.new
    end

    def create
      @exhibition = Exhibition.new(exhibition_params)
      if @exhibition.save
        redirect_to admin_exhibition_path(@exhibition), success: "Exhibition successfully created."
      else
        flash[:danger] = exhibition_errors
        render :new
      end
    end

    def edit
      redirect_to admin_exhibitions_path, warning: "Exhibition not found." unless @exhibition.present?
    end

    def update
      @exhibition.assign_attributes(exhibition_params)
      if @exhibition.save
        redirect_to admin_exhibition_path(@exhibition), success: "Exhibition successfully updated."
      else
        flash[:danger] = exhibition_errors
        render :edit
      end
    end

    def show
      redirect_to admin_exhibitions_path, warning: "Exhibition not found." unless @exhibition.present?
      @series = @exhibition.series
    end

    private

    def set_exhibition
      @exhibition = Exhibition.find_by(id: params[:id])
    end

    def exhibition_params
      params.require(:exhibition).permit(
        :title,
        :description,
        :start_at,
        :end_at
      )
    end

    def exhibition_errors
      @exhibition.errors.full_messages.join(', ')
    end
  end
end
