class Admin::UsersController < AdminController
  def index
    per_page = 15
    params[:page]||=1
    @start_num = (per_page.to_i * (params[:page].to_i-1)).to_i
    @users = User.paginate(page: params[:page], per_page: per_page).order('email')
  end

  def new
    @user = User.new()
  end

  def create
    @user = User.new(user_new_params)
    if @user.save
      flash[:success] = 'Створено нового користувача'
      redirect_to admin_users_path
    else
      flash[:error] = 'Помилка створення нового користувача'
      render :new
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
      if @user.nil?
      flash[:error] = 'Користувача не знайдено'
      redirect_to admin_users_path
     else
    end
  end

  def update
  user = User.find_by(id: params[:id])   
  if user.update(user_params)
      if params[:user][:password].present?
        user.password=params[:user][:password]
      end
      flash[:success] = 'Дані успішно збережені'
      redirect_to admin_users_path
    else
      flash[:error] = 'Помилка збереження даних'
      render :edit
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    if (@user.admin)or(@user.id==current_user.id)
      flash[:error] = 'Знищення користувача заборонено'
    else
      if @user.destroy
        flash[:notice] = 'Користувача знищено'
      else
        flash[:error] = 'Помилка знищення користувача'
      end
    end
    redirect_to admin_users_path
  end

private
 def user_params
      params.require(:user).permit(:email, :admin)
 end
def user_new_params
      params.require(:user).permit(:email, :admin, :password)
 end

end
