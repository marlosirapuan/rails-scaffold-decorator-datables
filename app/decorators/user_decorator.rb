class UserDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def link_to
    h.link_to object.name, h.user_path(object)
  end

  def link_email
    h.mail_to object.email
  end

  def level
    helpers.content_tag :span, class: "badge badge-pill badge-#{badge_level}" do
      admin? ? 'admin' : 'usuário'
    end
  end

  def label_status
    helpers.content_tag :span, class: "badge badge-pill badge-#{badge_user}" do
      enabled? ? 'ativo' : 'inativo'
    end
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def actions
    links = []
    links <<
      h.link_to(
        fa_icon('eye'), h.user_path(object), title: 'Visualizar',
        class: 'btn btn-sm text-primary'
      )
    links <<
      h.link_to(
        fa_icon('edit'), h.edit_user_path(object), title: 'Editar',
        class: 'btn btn-sm text-secondary'
      )
    links <<
      h.link_to(
        fa_icon('trash'), h.user_path(object), title: 'Excluir',
        class: 'btn btn-sm text-danger', data: { confirm: 'Confirma?', method: :delete }
      )

    helpers.content_tag :div, class: 'btn-group' do
      h.safe_join(links, '')
    end
  end

  private

  def admin?
    object.is_admin?
  end

  def badge_level
    admin? ? 'primary' : 'light'
  end

  def enabled?
    object.enabled?
  end

  def badge_user
    object.enabled? ? 'success' : 'danger'
  end
end
