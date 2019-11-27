class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :img, ImgUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}
  validates :in_reply_to, presence: false
  validate :img_size
  
  def Micropost.including_replies(user_id)
    Micropost.where("user_id        IN (:following_ids)
                   OR user_id     =   :user_id
                   OR in_reply_to =   :user_id")
  end

  private

    # アップロードされた画像のサイズをバリデーションする
    def img_size
      if img.size > 5.megabytes
        errors.add(:img, "should be less than 5MB")
      end
    end
end