module Admin
  class SeriesController < ApplicationController
    before_action :set_exhibition, except: %i[new]
    before_action :set_series, except: %i[new create]

    def new
      @series = Series.new
    end

    def create
      @series = Series.new(series_params.merge(exhibition: @exhibition))
      if @series.save
        redirect_to admin_exhibition_series_path(@exhibition.id, @series.id), success: "Series successfully created."
      else
        flash[:danger] = series_errors
        render :new
      end
    end

    def edit; end

    def update
      @series.assign_attributes(series_params)
      if @series.save
        redirect_to admin_exhibition_series_path(@exhibition.id, @series.id), success: "Series successfully updated."
      else
        flash[:danger] = series_errors
        render :edit
      end
    end

    def show; end

    def destroy
      @series.destroy

      redirect_to admin_exhibition_path(@exhibition.id), success: "Series successfully deleted."
    end

    private

    def set_exhibition
      @exhibition = Exhibition.find_by(id: params[:exhibition_id])
    end

    def set_series
      @series = Series.includes(:artworks).find_by(id: params[:id])
      redirect_to admin_exhibition_path(@exhibition.id) unless @series.present?
    end

    def series_params
      params.require(:series).permit(
        :title,
        :description,
        :artist_id,
        artwork_ids: []
      )
    end

    def series_errors
      @series.errors.full_messages.join(', ')
    end
  end
end
