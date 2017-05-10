# coding: utf-8
class Client < User
  has_attached_file :avatar, styles: { medium: "300x300#", thumb: "100x100#" }, default_url: "https://click.dj/img/no-avatar.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  has_attached_file :attachment
  has_many :gymcards
  has_many :assessments
  has_many :pollock3
  has_many :pollock7
  has_many :icq_assessments

  def age
    value = Time.now.year - self.birth_date.year
    
    return 'Não especificado' if value <= 0

    value
  end

  private

  def password_required?
    false
  end
end
