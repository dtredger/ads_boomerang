class ApplicationMailer < ActionMailer::Base
  default from: ENV["OUTGOING_EMAIL_ADDRESS"]
  layout 'mailers/base'

end
