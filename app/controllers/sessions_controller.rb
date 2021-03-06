class SessionsController <ApplicationController

  def new
  end

  def create
    @teacher = Teacher.find_by(email: session_params["email"])

    if @teacher
      if @teacher.authenticate(session_params["password"]) == @teacher

        login(@teacher)
        redirect_to students_path
      else
        if @teacher.authenticate(session_params["password"]) == false
          @errors = ["Password or Email is invalid"]
        else
          @errors = @teacher.errors.full_messages
        end
        render 'new'
      end
    end
  end

  def destroy
    logout
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
