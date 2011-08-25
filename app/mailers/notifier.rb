class Notifier < ActionMailer::Base
  default :from => "no-reply@diffme.com"

  def site_updated(site)
    @site = site
    @user = site.user
    mail(:to => @user.email,
         :subject => "Website content has changed.")
  end
end
