module UsersHelper
  def new_user?
    @user.new_record?
  end
end
