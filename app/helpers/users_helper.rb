module UsersHelper
  def job_title_icon
    if @user.profile.job_title == "Developer"
      "<i class='fa fa-code'></i>".html_safe
    elsif @user.profile.job_title == "Entrepeneur"
      "<i class='fa fa-lightbulb-o'></i>".html_safe
    elsif @user.profile.job_title == "Investor"
      "<i class='fa fa-dollar'></i>".html_safe
    end
  end
  
  def job_title_icon_index(n)
    if n == "Developer"
      "<i class='fa fa-code job-title-icon'></i>".html_safe
    elsif n == "Entrepeneur"
      "<i class='fa fa-lightbulb-o job-title-icon'></i>".html_safe
    elsif n == "Investor"
      "<i class='fa fa-dollar job-title-icon'></i>".html_safe
    end
  end
end