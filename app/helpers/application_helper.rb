# frozen_string_literal: true

module ApplicationHelper
  def bootstrap_class_for(name)
    {
      success: 'alert-success',
      error:   'alert-error',
      danger:  'alert-danger',
      alert:   'alert-warning',
      notice:  'alert-info'
    }[name.to_sym]
  end

  def access?(user)
    current_user == user || current_user.admin? if user_signed_in?
  end
end
