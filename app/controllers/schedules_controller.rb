class SchedulesController < ApplicationController

  helper_method :sort_column, :sort_direction

  def index
    @schedules = Schedule.all.order("#{sort_column} #{sort_direction}")
  end

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params)
    if @schedule.save
      flash[:notice] = "スケジュールを登録しました。"
      redirect_to :schedules
    else
      flash[:alert] = "スケジュールを登録できませんでした"
      render "new"
    end
  end

  def show
    @schedule = Schedule.find(params[:id])
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update(schedule_params)
      flash[:notice] = "スケジュールを編集しました。"
      redirect_to :schedules
    else
      flash[:alert] = "スケジュールを編集できませんでした"
      render "edit"
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    flash[:alert] = "スケジュールを削除しました"
    redirect_to :schedules
  end

  private

    def schedule_params
      params.require(:schedule).permit(:title, :start_date, :end_date, :all_day, :memo)
    end

    def sort_direction
      ["asc", "desc"].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def sort_column
      Schedule.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

end
