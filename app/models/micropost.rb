class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :img, ImgUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :img_size

  private

    # アップロードされた画像のサイズをバリデーションする
    def img_size
      if img.size > 5.megabytes
        errors.add(:img, "should be less than 5MB")
      end
    end
end