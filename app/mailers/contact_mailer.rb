class ContactMailer < ApplicationMailer
  def contact_mail(contact)
  @contact = contact

  mail to: @blog.user.email, subject: "お問い合わせの確認メール"

  end
end
